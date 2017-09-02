//
//  GameViewController.swift
//  Bout Time
//
//  Created by Alex Koumparos on 26/08/17.
//  Copyright © 2017 Koumparos Software. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, GameDelegate {
    
    
    //MARK: - Properties
    //------------------
    
    //MARK: IBOutlets
    @IBOutlet weak var topFactLabel: UILabel!
    @IBOutlet weak var topFactButton: UIButton!
    
    @IBOutlet weak var secondFactLabel: UILabel!
    @IBOutlet weak var secondFactUpButton: UIButton!
    @IBOutlet weak var secondFactDownButton: UIButton!
    
    @IBOutlet weak var thirdFactLabel: UILabel!
    @IBOutlet weak var thirdFactUpButton: UIButton!
    @IBOutlet weak var thirdFactDownButton: UIButton!
    
    @IBOutlet weak var fourthFactLabel: UILabel!
    @IBOutlet weak var fourthFactButton: UIButton!
    
    @IBOutlet weak var nextRoundStackView: UIStackView!
    
    @IBOutlet weak var timeRemainingStackView: UIStackView!
    
    @IBOutlet weak var nextRoundWithStatusButton: UIButton!
    
    @IBOutlet weak var timeRemainingLabel: UILabel!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: UI Element groups
    private var factsLabels = [UILabel]()
    private var labelTexts = [String]()
    private var buttons = [UIButton]()
    
    //MARK: Other properties
    private var game: Game!
    
    private var shakeEnabled = false

    
    //MARK: - View Controller Methods
    //-------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttons = [topFactButton,
                   secondFactUpButton,
                   secondFactDownButton,
                   thirdFactUpButton,
                   thirdFactDownButton,
                   fourthFactButton]
        
        
        factsLabels = [topFactLabel,
                       secondFactLabel,
                       thirdFactLabel,
                       fourthFactLabel]
        
        
        startNewGame()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        print("Shake detected")
        
        if shakeEnabled {
            game.userDidEndRound()
        }
    }
    
    
    //MARK: - Navigation Methods
    //--------------------------
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier {
            switch id {
                case "toGameOverViewController":
                let destination = segue.destination as! GameOverViewController
                destination.numerator = 1
                destination.denominator = 6
                
                case "toWebViewViewController":
                let destination = segue.destination as! WebViewViewController
                
                destination.url = sender as! URL
                
                
            default:
                print("unknown destination")
            }
        }
    }
    
    
    
    //MARK: - IBActions
    //-----------------
    
    @IBAction func downButtonTapped(_ sender: UIButton) {
        // change button to red image
        // change any other button to yellow
        resetButtonImages(buttons: buttons)
        updateButtonImage(button: sender, selected: true, isUp: false)
        
        labelTexts = switchStrings(arr: labelTexts, position: sender.tag, directionUp: false)
        for (index, label) in factsLabels.enumerated() {
            label.text = labelTexts[index]
        }
        
        
    }
    
    @IBAction func upButtonTapped(_ sender: UIButton) {
        resetButtonImages(buttons: buttons)
        updateButtonImage(button: sender, selected: true, isUp: true)
        
        labelTexts = switchStrings(arr: labelTexts, position: sender.tag, directionUp: true)
        for (index, label) in factsLabels.enumerated() {
            label.text = labelTexts[index]
        }
    }
    
    @IBAction func nextRoundButtonTapped(_ sender: UIButton) {
        switch game.getGameState() {
        case .gameOver:
            print("\(game.getScore)")
            viewDidLoad()
        case .correct, .incorrect:
            game.readyForNextRound()
        case .inRound:
            print("should not be able to tap next round button if game state is inRound")
        }
    }
    
    @IBAction func tapGestureRecognizerTapped(_ sender: UITapGestureRecognizer) {
        
        // If we are not in a round (shouldn't be able to segue to web view if in the middle of an active round)
        // AND if we can resolve the tapped view's tag (should always be possible)
        // AND if we can resolve a URL from the event text corresponding to the tag's position in the label array
        // THEN send that url to the destination to be displayed
        
        if game.getGameState() != .inRound {
            if let tag = sender.view?.tag {
                
                let eventText = labelTexts[tag]
                
                if let url = game.getUrlFor(event: eventText) {
                    performSegue(withIdentifier: "toWebViewViewController", sender: url)
                } else {
                    print("unable to resolve a url for the specified event text")
                }
                
            } else {
                print("unable to resolve a tag for the indicated sender")
            }
        }
        
    }
    
    @IBAction func unwindToGameViewController(segue: UIStoryboardSegue) {
        
        if let id = segue.identifier {
            switch id {
                case "unwindToGameViewControllerFromGameOverViewController":
                startNewGame()
            default :
                print("came from some other segue")
            }
        }
        
        
    }
    
    //MARK: - GameDelegate Methods
    //----------------------------
    func timeRemainingDidChange() {
        updateTimeRemainingLabel()
    }
    
    func timeExpired() {
        updateTimeRemainingLabel(timeUp: true)
    }
    
    func gameDidStart() {
        // currently no specific behaviours required for the view controller when the game has started
        print("GVC: Game told me that the game did start")
    }
    
    func gameDidEnd() {
        print("Game told me that the game did end")
        performSegue(withIdentifier: "toGameOverViewController", sender: self)
    }
    
    func roundDidStart() {
        print("Game told me that the round did start")
        setButtonsEnabledStatus(true)
        
        //show timer
        //show shake instructions
        //hide tap-to-show-webview button
        //hide result image
        setFooterDisplay()
        
        //enable shake
        shakeEnabled = true
        
        
        loadLabelStrings()
        updateTimeRemainingLabel()
    }
    
    func roundDidEnd() {
        print("game told me that the round did end")
        setButtonsEnabledStatus(false)
        
        // hide timer
        // hide shake instruction
        // show tap-to-show-webview button
        // show result image
        setFooterDisplay()
        
        // disable shake
        shakeEnabled = false
        
    }
    
    func readyForNextRound() {
        game.readyForNextRound()
    }
    
    func getEventStrings() -> [String] {
        return game.getEventStrings()
    }
    
    func getRemainingTime() -> Double {
        return game.getRemainingTime()
    }

    
    //MARK: - Other Methods
    //---------------------
    
    func loadLabelStrings() {
        labelTexts = getEventStrings()
        
        for (index, label) in factsLabels.enumerated() {
            label.text = labelTexts[index]
        }
    }

    /**
     takes an array of strings and switches two elements around depending on the specified position in the array and the direction of movement
    */
    func switchStrings(arr: [String], position: Int, directionUp: Bool) -> [String] {
        
        
        var tempArr = arr
        
        if directionUp {
            
            guard position > 0 else { return arr }
            
            tempArr[position - 1] = arr[position]
            tempArr[position] = arr[position - 1]
        } else {
            
            guard position < arr.count - 1 else { return arr }
            
            tempArr[position + 1] = arr[position]
            tempArr[position] = arr[position + 1]
        }
        
        return tempArr
    }
    
    func updateButtonImage(button: UIButton, selected: Bool, isUp: Bool) {
        
        switch button {
        case _ where button.tag == 0:
            // first button, only has fullsize down
            
            selected ? button.setImage(#imageLiteral(resourceName: "down_full_selected"), for: .normal): button.setImage(#imageLiteral(resourceName: "down_full"), for: .normal)
            
        case _ where button.tag == factsLabels.count - 1:
            // last button, only has fullsize up
            
            selected ? button.setImage(#imageLiteral(resourceName: "up_full_selected"), for: .normal): button.setImage(#imageLiteral(resourceName: "up_full"), for: .normal)
            
        default:
            // in-between button, has halfsize up and down
            // odd-indexed buttons are ups, even-indexed buttons are down
            if isUp {
                
                selected ? button.setImage(#imageLiteral(resourceName: "up_half_selected"), for: .normal): button.setImage(#imageLiteral(resourceName: "up_half"), for: .normal)
            } else {
                selected ? button.setImage(#imageLiteral(resourceName: "down_half_selected"), for: .normal): button.setImage(#imageLiteral(resourceName: "down_half"), for: .normal)
            }
            
        }
        
    }
    
    func resetButtonImages(buttons: [UIButton]) {
        
        for (index, button) in buttons.enumerated() {
            
            let isUp = index % 2 == 1
            
            updateButtonImage(button: button, selected: false, isUp: isUp)
        }
        
    }
    
    func updateTimeRemainingLabel(timeUp: Bool = false) {
        
        if timeUp {
            timeRemainingLabel.text = "0"
        } else {
            let timeRemaining = Int(getRemainingTime())
            timeRemainingLabel.text = "\(timeRemaining)"
        }
        
    }
    
    private func setFooterDisplay() {
        
        switch game.getGameState() {
        case .inRound:
            // should display timeRemainingStackView and hide nextRoundStackView
            timeRemainingStackView.isHidden = false
            nextRoundStackView.isHidden = true
            
        case .correct:
            // should display nextRoundStackView with 'success' image
            // and hide timeRemainingStackView
            nextRoundWithStatusButton.setImage(#imageLiteral(resourceName: "next_round_success"), for: .normal)
            nextRoundStackView.isHidden = false
            timeRemainingStackView.isHidden = true
            
        case .incorrect:
            // should display nextRoundStackView with 'fail' image
            // and hide timeRemainingStackView
            nextRoundWithStatusButton.setImage(#imageLiteral(resourceName: "next_round_fail"), for: .normal)
            nextRoundStackView.isHidden = false
            timeRemainingStackView.isHidden = true

            
        case .gameOver:
            // shouldn't matter: view will segue to gameoverviewcontroller
            print("GVC: setFooterDisplay doesn't need to do anything, game is over")
        }
    }
    
    public func getLabelTexts() -> [String] {
        return labelTexts
    }
    
    private func setButtonsEnabledStatus(_ status: Bool) {
        buttons.forEach {
            $0.isEnabled = status
        }
    }
    
    public func startNewGame() {
        
        labelTexts = [" ",
                      " ",
                      " ",
                      " "]
        
        
        resetButtonImages(buttons: buttons)
        setButtonsEnabledStatus(false)
        
        game = Game()
        game.delegate = self
        game.startGame()
        
        
    }
    
    
}


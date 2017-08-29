//
//  ViewController.swift
//  Bout Time
//
//  Created by Alex Koumparos on 26/08/17.
//  Copyright © 2017 Koumparos Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GameDelegate {
    
    
    //MARK: - Properties
    //------------------
    
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
    
    @IBOutlet weak var nextRoundWithStatusImageView: UIImageView!
    
    @IBOutlet weak var timeRemainingLabel: UILabel!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var factsLabels = [UILabel]()
    var labelTexts = [String]()
    var buttons = [UIButton]()
    
    var game: Game!
    
    
    //MARK: - View Controller Methods
    //-------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        buttons = [topFactButton, secondFactUpButton, secondFactDownButton, thirdFactUpButton, thirdFactDownButton, fourthFactButton]
        
        
        factsLabels = [topFactLabel, secondFactLabel, thirdFactLabel, fourthFactLabel]
        labelTexts = ["Sputnick was launched by the USSR",
                      "Roger Maris broke the Babe's HR record",
                      "Start of the Korean War",
                      "George McFly first kisses Lorraine"]
        
        
        resetButtonImages(buttons: buttons)
        
        game = Game(vc: self, rounds: 6, secondsPerRound: 5)
        game.testMessage()
        game.startGame()

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        print("Shake detected")
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
    
    //MARK: - GameDelegate Methods
    //----------------------------
    func timeRemainingDidChange() {
        updateTimeRemainingLabel()
    }
    
    func timeExpired() {
        updateTimeRemainingLabel(timeUp: true)
        //readyForNextRound()
    }
    
    func gameDidStart() {
        print("Game told me that the game did start")
    }
    
    func gameDidEnd() {
        print("Game told me that the game did end")
    }
    
    func roundDidStart() {
        print("Game told me that the round did start")
        updateTimeRemainingLabel()
    }
    
    func roundDidEnd() {
        print("game told me that the round did end")
    }
    
    func readyForNextRound() {
        game.readyForNextRound()
    }

    
    //MARK: - Other Methods
    //---------------------

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
            let timeRemaining = Int(game.getRemainingTime())
            timeRemainingLabel.text = "\(timeRemaining)"
        }
        
    }
    
    
}


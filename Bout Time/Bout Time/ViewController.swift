//
//  ViewController.swift
//  Bout Time
//
//  Created by Alex Koumparos on 26/08/17.
//  Copyright © 2017 Koumparos Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
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
    
    //MARK: - View Controller Methods
    //-------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        factsLabels = [topFactLabel, secondFactLabel, thirdFactLabel, fourthFactLabel]
    
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
    
    @IBAction func topFactButtonTapped(_ sender: UIButton) {
        // change button to red image
        // change any other button to yellow
        // make label at button index + 1 (mod 4) == label at button index i
        // make label at button index i == old label at button index + 1
    }
    
    @IBAction func secondFactUpButtonTapped(_ sender: UIButton) {
    }

    @IBAction func secondFactDownButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func thirdFactUpButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func thirdFactDownButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func fourthFactButtonTapped(_ sender: UIButton) {
    }
    
    //MARK: - Other Methdos
    //---------------------

}


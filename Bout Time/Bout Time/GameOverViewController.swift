//
//  GameOverViewController.swift
//  Bout Time
//
//  Created by Alex Koumparos on 31/08/17.
//  Copyright © 2017 Koumparos Software. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {
    
    
    //MARK: - Properties
    //------------------
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    var numerator: Int!
    var denominator: Int!

    
    //MARK: - ViewController Methods
    //------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "\(numerator)/\(denominator)"
        
    }

    
    //MARK: - IBActions
    //-----------------

    @IBAction func playAgainButton(_ sender: UIButton) {
        // set up new game
        // unwind to GameViewController
        performSegue(withIdentifier: "unwindToGameViewControllerFromGameOverViewController", sender: nil)
    }
}

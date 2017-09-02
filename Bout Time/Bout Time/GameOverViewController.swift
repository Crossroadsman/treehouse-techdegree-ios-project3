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
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    
    //MARK: - ViewController Methods
    //------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let numerator = numerator, let denominator = denominator else {
            fatalError("Unable to resolve score")
        }
        
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

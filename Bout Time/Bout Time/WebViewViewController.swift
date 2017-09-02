//
//  WebViewViewController.swift
//  Bout Time
//
//  Created by Alex Koumparos on 31/08/17.
//  Copyright © 2017 Koumparos Software. All rights reserved.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {
    
    //MARK: - Properties
    //------------------

    @IBOutlet weak var webContentView: UIView!
    var webKitWebView: WKWebView!
    
    var url: URL!
    
    
    //MARK: - View Controller Methods
    //-------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webKitWebView = WKWebView(frame: webContentView.frame)
        webContentView.addSubview(webKitWebView)
        constrainView(webKitWebView, toView: webContentView)
        
        let urlRequest = URLRequest(url: url)
        webKitWebView.load(urlRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func exitButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToGameViewControllerFromWebViewViewController", sender: nil)
    }
    
    //MARK: - Other Methods
    //---------------------
    
    func constrainView(_ view: UIView, toView constrainingView: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        // set constraints
        view.leadingAnchor.constraint(equalTo: constrainingView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: constrainingView.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: constrainingView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: constrainingView.bottomAnchor).isActive = true
        
    }

}

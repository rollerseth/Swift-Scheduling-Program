//
//  ViewController.swift
//  SchedulingApp
//
//  Created by Seth Roller on 1/13/18.
//  Copyright © 2018 Seth Roller. All rights reserved.
//

import UIKit

class Home: UIViewController {
    
    @IBOutlet weak var signInbutton: UIButton!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passText: UITextField!
    @IBOutlet weak var signingUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signingUpButton.layer.cornerRadius = 8
        signInbutton.layer.cornerRadius = 8
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sigingIn(_ sender: Any) {
    }
    
    
    
    
    
}


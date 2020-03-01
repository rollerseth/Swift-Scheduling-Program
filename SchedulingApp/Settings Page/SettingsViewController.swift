//
//  SettingsViewController.swift
//  SchedulingApp
//
//  Created by Seth Roller on 1/23/18.
//  Copyright © 2018 Seth Roller. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var AccountOverviewLabel: UIButton!
    
    @IBOutlet weak var editProfileLabel: UIButton!
    @IBOutlet weak var notificationsLabel: UIButton!
    @IBOutlet weak var favoritesLabel: UIButton!
    @IBOutlet weak var paymentLabel: UIButton!
    
    @IBOutlet weak var signOutButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        changeButtonStatus(value: AccountOverviewLabel)
        changeButtonStatus(value: editProfileLabel)
        changeButtonStatus(value: notificationsLabel)
        changeButtonStatus(value: favoritesLabel)
        changeButtonStatus(value: paymentLabel)
        
        signOutButton.layer.shadowColor = UIColor.white.cgColor
        signOutButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        signOutButton.layer.shadowRadius = 5
        signOutButton.layer.shadowOpacity = 0.75
        
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

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func changeButtonStatus(value: UIButton) {
        
        value.layer.cornerRadius = 8
        value.layer.shadowColor = UIColor.black.cgColor
        value.layer.shadowOffset = CGSize(width: 2, height: 2)
        value.layer.shadowRadius = 5
        value.layer.shadowOpacity = 0.75
        value.layer.borderWidth = 1.5
        value.layer.borderColor = UIColor.black.cgColor
        
    }
    
    
    
    
    
    
}

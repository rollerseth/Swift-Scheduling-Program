//
//  PaymentInformation.swift
//  SchedulingApp
//
//  Created by Seth Roller on 1/17/18.
//  Copyright © 2018 Seth Roller. All rights reserved.
//

import UIKit

class PaymentInformation: UIViewController {
    
    @IBOutlet weak var finishButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        finishButton.layer.cornerRadius = 7
        
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
    

}

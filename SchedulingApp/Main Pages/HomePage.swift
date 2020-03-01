//
//  HomePage.swift
//  SchedulingApp
//
//  Created by Seth Roller on 1/17/18.
//  Copyright © 2018 Seth Roller. All rights reserved.
//

import UIKit
import QuartzCore

class HomePage: UIViewController {

    @IBOutlet weak var skedgeTitleLable: UILabel!
    @IBOutlet weak var todayAnnouncement: UILabel!
    
    @IBOutlet weak var redback: UIView!
    var timer = Timer()
    
    @IBOutlet weak var upcomingEvents: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        todayAnnouncement.layer.masksToBounds = true
        todayAnnouncement.layer.cornerRadius = 10
        
        upcomingEvents.layer.masksToBounds = true
        upcomingEvents.layer.cornerRadius = 10
 
        changeViewStatus(value: redback)
        changeViewStatus(value: upcomingEvents)
        
        skedgeTitleLable.layer.shadowColor = UIColor.darkGray.cgColor
        skedgeTitleLable.layer.shadowOffset = CGSize(width: 2, height: 2)
        skedgeTitleLable.layer.shadowRadius = 5
        skedgeTitleLable.layer.shadowOpacity = 0.75
        
        
        
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.
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

    @objc func updateTimer() {
        
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .short
        
        let appearDate = dateFormat.string(from: NSDate() as Date)
        
        todayAnnouncement.text = "Welcome to Skedge, today is \(appearDate)"
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    func changeViewStatus(value: UIView) {
        
        value.layer.shadowColor = UIColor.black.cgColor
        value.layer.shadowOffset = CGSize(width: 2, height: 2)
        value.layer.shadowRadius = 5
        value.layer.shadowOpacity = 0.75
        value.layer.cornerRadius = 8
        value.layer.borderColor = UIColor.black.cgColor
        value.layer.borderWidth = 1.5
        
        
    }
    
        
    }
    
    


//
//  SearchViewController.swift
//  SchedulingApp
//
//  Created by Seth Roller on 1/19/18.
//  Copyright © 2018 Seth Roller. All rights reserved.
//

import UIKit
import Firebase

class SearchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var changingName: UILabel!
    @IBOutlet weak var LabelBar: UILabel!
    @IBOutlet weak var LabelBar1: UILabel!
    @IBOutlet weak var LabelBar2: UILabel!
    @IBOutlet weak var HoursLabel: UILabel!
    
    @IBOutlet weak var redBack: UIView!
    
    @IBOutlet weak var appointments: UIButton!
    @IBOutlet weak var genderPicker: UIPickerView!
    @IBOutlet weak var pickASylistLabel: UILabel!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var pickADateLabel: UILabel!
    
    @IBOutlet weak var datePicking: UIDatePicker!
    
    
    var datasent:String!
    var genderPick: [String] = [String]()
    var sentData:String!
    
    // need to incorporate a loop that runs through the database entries for the stylists and display them then 
    
    //need to setup a var list from the database

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.genderPicker.delegate = self
        self.genderPicker.dataSource = self
        
        self.navigationItem.title = sentData
        
        LabelBar.layer.masksToBounds = true
        LabelBar1.layer.masksToBounds = true
        LabelBar2.layer.masksToBounds = true
        
        changingName.layer.masksToBounds = true
        changingName.layer.shadowColor = UIColor.darkGray.cgColor
        changingName.layer.shadowOffset = CGSize(width: 2, height: 2)
        changingName.layer.shadowRadius = 5
        changingName.layer.shadowOpacity = 0.75
        
        redBack.layer.cornerRadius = 8
        redBack.layer.shadowColor = UIColor.black.cgColor
        redBack.layer.shadowOffset = CGSize(width: 2, height: 2)
        redBack.layer.shadowRadius = 5
        redBack.layer.shadowOpacity = 0.75
        redBack.layer.borderColor = UIColor.black.cgColor
        redBack.layer.borderWidth = 1.5
        
        LabelBar.layer.cornerRadius = 8
        LabelBar1.layer.cornerRadius = 8
        LabelBar2.layer.cornerRadius = 8
        redBack.layer.cornerRadius = 8
        appointments.layer.cornerRadius = 8
    
        appointments.layer.shadowColor = UIColor.darkGray.cgColor
        appointments.layer.shadowOffset = CGSize(width: 2, height: 2)
        appointments.layer.shadowRadius = 5
        appointments.layer.shadowOpacity = 0.75
        
        pickASylistLabel.layer.shadowColor = UIColor.darkGray.cgColor
        pickADateLabel.layer.shadowColor = UIColor.darkGray.cgColor
        changingName.layer.shadowColor = UIColor.darkGray.cgColor
        HoursLabel.layer.shadowColor = UIColor.black.cgColor

        locationButton.layer.shadowColor = UIColor.white.cgColor
        locationButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        locationButton.layer.shadowRadius = 5
        locationButton.layer.shadowOpacity = 0.75
        
        changeLabelStatus(value: HoursLabel)
        changeLabelStatus(value: pickASylistLabel)
        changeLabelStatus(value: pickADateLabel)
        
       // genderPicker.description.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderPick.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderPick[row]
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func changingPickerView(pickerView: UIPickerView) -> Int {
        
      return pickerView.selectedRow(inComponent: 0)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "FindAppointments") {
            
            let dvc = segue.destination as! SearchingTableViewController
            
            let format = pickerView(genderPicker, titleForRow: changingPickerView(pickerView: genderPicker), forComponent: 1)
            
            datePicking.datePickerMode = .date
            let formatter = DateFormatter()
            formatter.dateStyle = .short
        
            let text = formatter.string(from: datePicking.date)
            
            dvc.dateData = text
            
            dvc.stylistData = format
           
        }
        
        }
    
    func changeLabelStatus(value: UILabel) {
        
        value.layer.masksToBounds = true
        value.layer.cornerRadius = 8
        value.layer.shadowColor = UIColor.black.cgColor
        value.layer.shadowOffset = CGSize(width: 2, height: 2)
        value.layer.shadowRadius = 5
        value.layer.shadowOpacity = 0.75
        
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}

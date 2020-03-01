//
//  BookingFirstPage.swift
//  SchedulingApp
//
//  Created by Seth Roller on 1/30/18.
//  Copyright © 2018 Seth Roller. All rights reserved.
//

import UIKit

class BookingFirstPage: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    

    @IBOutlet weak var businessPicking: UIPickerView!
    @IBOutlet weak var stylistPicking: UIPickerView!
    
    @IBOutlet weak var datePicking1: UIDatePicker!
    @IBOutlet weak var ZPcodeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var businessLabel: UILabel!
    @IBOutlet weak var stylistLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var redBackground: UIView!
    
    @IBOutlet weak var ZPTextField: UITextField!
    
    
    var stylistPick: [String] = [String]()
    var businessPick: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ZPTextField.layer.masksToBounds = true
        ZPTextField.layer.shadowRadius = 5
        ZPTextField.layer.shadowOpacity = 0.75
        ZPTextField.layer.shadowOffset = CGSize(width: 2, height: 2)
        ZPTextField.layer.shadowColor = UIColor.black.cgColor
        ZPTextField.layer.cornerRadius = 8
        ZPTextField.layer.borderWidth = 2.3
        ZPTextField.layer.borderColor = UIColor.black.cgColor
        
        businessPicking.delegate = self
        businessPicking.dataSource = self
        stylistPicking.dataSource = self
        stylistPicking.delegate = self
        
        
        stylistPick = ["Ann", "Marie", "Julie"]
        businessPick = ["Business 1", "Business 2", "Business 3"]
        
        changeLabelStatus(value: businessLabel)
        changeLabelStatus(value: stylistLabel)
        changeLabelStatus(value: ZPcodeLabel)
        changeLabelStatus(value: dateLabel)
        
        searchButton.layer.shadowColor = UIColor.white.cgColor
        searchButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        searchButton.layer.shadowRadius = 5
        searchButton.layer.shadowOpacity = 0.75
        
        changePicker(pickerView: businessPicking)
        changePicker(pickerView: stylistPicking)
        
        datePicking1.layer.masksToBounds = true
        datePicking1.layer.cornerRadius = 18
        datePicking1.layer.borderWidth = 1.5
        datePicking1.layer.borderColor = UIColor.black.cgColor
        datePicking1.layer.backgroundColor = UIColor(red: 76/255, green: 85/255, blue: 104/255, alpha: 1.0).cgColor
       
        redBackground.layer.cornerRadius = 8
        redBackground.layer.borderWidth = 1.5
        redBackground.layer.borderColor = UIColor.black.cgColor
        redBackground.layer.shadowColor = UIColor.black.cgColor
        redBackground.layer.shadowOffset = CGSize(width: 2, height: 2)
        redBackground.layer.shadowRadius = 5
        redBackground.layer.shadowOpacity = 0.75
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if (pickerView.tag == 0) {
            return businessPick.count
        }
        
        else {
            return stylistPick.count
        }
        
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 0) {
            return businessPick[row]
        }
        
        else {
            return stylistPick[row]
        }
        
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func changingPickerView(pickerView: UIPickerView) -> Int {
        
        return pickerView.selectedRow(inComponent: 0)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "searchFromBook") {
            
            let dvc = segue.destination as! SearchingTableViewController
            
       //     let formatBusiness = pickerView(businessPicking, titleForRow: changingPickerView(pickerView: businessPicking), forComponent: 1)
          
            let formatStylist = pickerView(stylistPicking, titleForRow: changingPickerView(pickerView: stylistPicking), forComponent: 1)
            
            datePicking1.datePickerMode = .date
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            
            let dateText = formatter.string(from: datePicking1.date)
            
            dvc.stylistData2 = formatStylist
            dvc.dateData2 = dateText
            
            
            
        }
        
    }
    
    
    
    func changePicker(pickerView: UIPickerView) {
        
        pickerView.layer.masksToBounds = true
        pickerView.layer.cornerRadius = 18
        pickerView.layer.borderWidth = 1.5
        pickerView.layer.borderColor = UIColor.black.cgColor
        
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

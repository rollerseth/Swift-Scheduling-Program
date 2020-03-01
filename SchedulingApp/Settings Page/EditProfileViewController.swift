//
//  EditProfileViewController.swift
//  SchedulingApp
//
//  Created by Seth Roller on 1/23/18.
//  Copyright © 2018 Seth Roller. All rights reserved.
//

import UIKit
import Firebase

class EditProfileViewController: UIViewController {
    
    var parameter: String!
    var logRef: DocumentReference!
    var profileRef: DocumentReference!

    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var ZPLabel: UILabel!
    @IBOutlet weak var lastLabel: UILabel!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var changePass: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var ZPText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    
    var docRef: DocumentReference!
    var docListener: ListenerRegistration!
    
    var genderPicker2: [String] = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        changePass.layer.shadowColor = UIColor.white.cgColor
        changePass.layer.shadowOffset = CGSize(width: 2, height: 2)
        changePass.layer.shadowRadius = 5
        changePass.layer.shadowOpacity = 0.75
        
        
        saveButton.layer.shadowColor = UIColor.white.cgColor
        saveButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        saveButton.layer.shadowRadius = 5
        saveButton.layer.shadowOpacity = 0.75
        
        changeLabelStatus(value: phoneLabel)
        changeLabelStatus(value: ZPLabel)
        changeLabelStatus(value: emailLabel)
        changeLabelStatus(value: lastLabel)
        changeLabelStatus(value: firstLabel)
        
        changeTextFieldStatus(value: firstNameText)
        changeTextFieldStatus(value: lastNameText)
        changeTextFieldStatus(value: ZPText)
        changeTextFieldStatus(value: emailText)
        changeTextFieldStatus(value: phoneText)
        
        let user = Auth.auth().currentUser
        
        if let user = user
        {
            let uid = user.uid
            let userEmail = user.email
            
            docRef = Firestore.firestore().document("Users/\(uid)/UserInfo/Profile")
            docListener = docRef.addSnapshotListener {(docSnapshot, Error) in
                guard let docSnapshot = docSnapshot, (docSnapshot.exists)
                    else
                {
                    let dataFetchingError = UIAlertController(title: "Data Fetching Error", message: "\(Error?.localizedDescription ?? "Could not fetch data at this moment.") Please try again. ", preferredStyle: .alert)
                    dataFetchingError.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(dataFetchingError, animated: true, completion: nil)
                    return
                }
                
                //docRef.setData(["Email" : userEmail ?? "(none)", "Phone Number" : userPhoneNumber ?? "(none)"])
                let myData = docSnapshot.data()
                
                let firstName = myData!["First Name"] as? String ?? ""
                let lastName = myData!["Last Name"] as? String ?? ""
                let zipCode = myData!["Zip Code"] as? String ?? ""
                let phone = myData!["Phone Number"] as? String ?? ""
        
                self.firstNameText.text = firstName
                self.lastNameText.text = lastName
                self.ZPText.text = zipCode
                self.emailText.text = userEmail
                self.phoneText.text = phone
                
        
    }
            
            
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
    
    // The number of rows of data
   
    
    // The data to return for the row and component (column) that's being passed in


    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 */
    
    func changeLabelStatus(value: UILabel) {
        
        value.layer.masksToBounds = true
        value.layer.shadowColor = UIColor.black.cgColor
        value.layer.shadowOffset = CGSize(width: 2, height: 2)
        value.layer.shadowRadius = 5
        value.layer.shadowOpacity = 0.75
        
    }
    
    func changeTextFieldStatus(value: UITextField) {
        
        value.layer.shadowColor = UIColor.black.cgColor
        value.layer.shadowOffset = CGSize(width: 2, height: 2)
        value.layer.shadowRadius = 5
        value.layer.shadowOpacity = 0.75
        value.layer.borderColor = UIColor.black.cgColor
        value.layer.borderWidth = 2.0
        value.layer.cornerRadius = 8
        
    }
    
    @IBAction func savingProfile(_ sender: Any) {
        
        let user = Auth.auth().currentUser
        
        if let user = user {
            
            let uid = user.uid
            let email = user.email
            
            self.logRef = Firestore.firestore().document("Users/\(uid)/UserInfo/Logs")
            self.logRef.setData(["isFirstTimeSignIn" : false])
         
            docListener = docRef.addSnapshotListener {(docSnapshot, Error) in
                guard let docSnapshot = docSnapshot, (docSnapshot.exists)
                    else
                {
                    let dataFetchingError = UIAlertController(title: "Data Fetching Error", message: "\(Error?.localizedDescription ?? "Could not fetch data at this moment.") Please try again. ", preferredStyle: .alert)
                    dataFetchingError.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(dataFetchingError, animated: true, completion: nil)
                    return
                }
                
                //docRef.setData(["Email" : userEmail ?? "(none)", "Phone Number" : userPhoneNumber ?? "(none)"])
                let myData = docSnapshot.data()
                
                let firstName = myData!["First Name"] as? String ?? ""
                let lastName = myData!["Last Name"] as? String ?? ""
                let zipCode = myData!["Zip Code"] as? String ?? ""
               // let phone = myData!["Phone Number"] as? String ?? ""
                
                
                self.profileRef = Firestore.firestore().document("Users/\(uid)/UserInfo/Profile")
                
                if self.firstNameText.text != firstName {
                    
                    self.profileRef.setData(["First Name": self.firstNameText.text!], options: SetOptions.merge())
                }
                
                if self.lastNameText.text != lastName {
                    
                    self.profileRef.setData(["Last Name": self.lastNameText.text!], options: SetOptions.merge())
                }
                
                if self.ZPText.text != zipCode {
                    
                    self.profileRef.setData(["Zip Code": self.ZPText.text!], options: SetOptions.merge())
                }
                
                // phone number goes here
                
            }
                
                
            }
            
            
        
        
        
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    
}

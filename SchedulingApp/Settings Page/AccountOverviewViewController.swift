//
//  AccountOverviewViewController.swift
//  SchedulingApp
//
//  Created by Seth Roller on 1/23/18.
//  Copyright © 2018 Seth Roller. All rights reserved.
//

import UIKit
import Firebase

class AccountOverviewViewController: UIViewController {
    
    @IBOutlet weak var displayEmail: UILabel!
    @IBOutlet weak var displayDOB: UILabel!
    @IBOutlet weak var displayCountry: UILabel!
    @IBOutlet weak var displayZC: UILabel!
    
    @IBOutlet weak var deleteAccount: UIButton!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var DOBLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var ZPCodeLabel: UILabel!
    
    @IBOutlet weak var profileNameLabel: UILabel!
    
    var docRef: DocumentReference!
    var docListener: ListenerRegistration!

    
    // need a variable list of strings for first names, email, DOB, country, and zip

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                let birthday = myData!["Birthday"] as? String ?? ""
                
                self.displayEmail.text = userEmail
                self.profileNameLabel.text = "\(firstName) \(lastName)"
                self.displayZC.text = "\(zipCode)"
                self.displayDOB.text = "\(birthday)"
            }
        
        }
        
        changeLabelStatus(value: displayZC)
        changeLabelStatus(value: displayDOB)
        changeLabelStatus(value: displayEmail)
        changeLabelStatus(value: displayCountry)
        changeLabelStatus(value: DOBLabel)
        changeLabelStatus(value: profileNameLabel)
        changeLabelStatus(value: ZPCodeLabel)
        changeLabelStatus(value: countryLabel)
        changeLabelStatus(value: emailLabel)
        
        displayDOB.layer.borderWidth = 1.5
        displayDOB.layer.borderColor = UIColor.black.cgColor
        
        displayZC.layer.borderWidth = 1.5
        displayZC.layer.borderColor = UIColor.black.cgColor
        
        displayEmail.layer.borderWidth = 1.5
        displayEmail.layer.borderColor = UIColor.black.cgColor
        
        displayCountry.layer.borderWidth = 1.5
        displayCountry.layer.borderColor = UIColor.black.cgColor
        
        deleteAccount.layer.shadowColor = UIColor.white.cgColor
        deleteAccount.layer.shadowOffset = CGSize(width: 2, height: 2)
        deleteAccount.layer.shadowRadius = 5
        deleteAccount.layer.shadowOpacity = 0.75
        
        
        //displayCountry.text = countryList[0]
        
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
    
    
    @IBAction func deleteAccount1(_ sender: Any) {
        
        // Delete Account Action
        
        let deleteAccountAlert = UIAlertController(title: "Delete Your Account", message: "Once you delete your account, there is no going back. Please be certain.", preferredStyle: .alert)
        
        deleteAccountAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(deleteAccountAlert, animated: true, completion: nil)
        
        deleteAccountAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler:{ (action) in
            self.performSegue(withIdentifier: "reauthenticateSegue", sender: self)
            
        }))

        
    }
    
    

}
    
    

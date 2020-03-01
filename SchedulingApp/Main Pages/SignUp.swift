//
//  SignUp.swift
//  SchedulingApp
//
//  Created by Seth Roller on 1/16/18.
//  Copyright © 2018 Seth Roller. All rights reserved.
//

import UIKit
import QuartzCore
import Firebase


class SignUp: UIViewController, BEMCheckBoxDelegate {
    
    @IBOutlet weak var maleCheck: BEMCheckBox!
    @IBOutlet weak var femaleCheck: BEMCheckBox!
    @IBOutlet weak var otherCheck: BEMCheckBox!
    @IBOutlet weak var moveOn: UIButton!
    @IBOutlet weak var maleLabel: UILabel!
    @IBOutlet weak var femaleLabel: UILabel!
    @IBOutlet weak var otherLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    
    @IBOutlet weak var phoneNumTextField: UITextField!
    
    @IBOutlet weak var backButton: UIButton!
    
    
    var gender: String!
    var profileRef: DocumentReference!
    var logRef: DocumentReference!
    
    // text fields
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var zipcodeTextField: UITextField!
    
    @IBOutlet weak var birthday: UIDatePicker!
    
    var birthdayString: String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        maleCheck.delegate = self
        femaleCheck.delegate = self
        otherCheck.delegate = self
        maleCheck.onAnimationType = .oneStroke
        femaleCheck.onAnimationType = .oneStroke
        otherCheck.onAnimationType = .oneStroke
 
        //corner radius
        
        changeLabelStatus(value: femaleLabel)
        changeLabelStatus(value: maleLabel)
        changeLabelStatus(value: otherLabel)
        changeLabelStatus(value: birthdayLabel)
        
        moveOn.layer.shadowColor = UIColor.black.cgColor
        moveOn.layer.shadowOffset = CGSize(width: 2, height: 2)
        moveOn.layer.shadowRadius = 5
        moveOn.layer.shadowOpacity = 0.75
        moveOn.layer.borderWidth = 1.5
        moveOn.layer.borderColor = UIColor.black.cgColor
        moveOn.layer.cornerRadius = 7
        
        changeTextFieldStatus(value: firstNameTextField)
        changeTextFieldStatus(value: lastNameTextField)
        changeTextFieldStatus(value: emailTextField)
        changeTextFieldStatus(value: passwordTextField)
        changeTextFieldStatus(value: confirmPasswordTextField)
        changeTextFieldStatus(value: zipcodeTextField)
        changeTextFieldStatus(value: phoneNumTextField)
        
        birthday.layer.masksToBounds = true
        birthday.layer.cornerRadius = 18
        birthday.layer.borderWidth = 1.5
        birthday.layer.borderColor = UIColor.black.cgColor
        birthday.layer.backgroundColor = UIColor(red: 211/255, green: 204/255, blue: 194/255, alpha: 1.0).cgColor
        
        backButton.layer.masksToBounds = true
        backButton.layer.cornerRadius = 18
        
        
        birthday.datePickerMode = .date
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        birthdayString = formatter.string(from: birthday.date)
        
    }
    // this is the checkButton feature
    // this also returns the string representation of gender
    func didTap(_ checkBox: BEMCheckBox) {
        
        if checkBox.tag == 1 {
            femaleCheck.on = false
            otherCheck.on = false
            gender = "Male"
        }
        if checkBox.tag == 2 {
            maleCheck.on = false
            otherCheck.on = false
            gender = "Female"
        }
        if checkBox.tag == 3 {
            femaleCheck.on = false
            maleCheck.on = false
            gender = "Other"
        }
       
        print(gender)
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
    
    // make this so that when they push the signin button they create a user

    
    func sendVerificationEmail()
    {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!)
        {
            (User, Error) in
            if Error != nil
            {
                print("Internal Error: \(Error!.localizedDescription)")
                return
            }
            Auth.auth().currentUser?.sendEmailVerification(completion: { (Error) in
                if Error != nil
                {
                    let emailNotSentAlert = UIAlertController(title: "Email Verification Error", message: "Verification Email Failed to Send: \(Error!.localizedDescription)", preferredStyle: .alert)
                    emailNotSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(emailNotSentAlert, animated: true, completion: nil)
                }
                else
                {
                    let emailSentAlert = UIAlertController(title: "Email Verification", message: "Verification Email has been sent. Please check your Email and click the link to verify your account.", preferredStyle: .alert)
                    emailSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(emailSentAlert, animated: true, completion: nil)
                }
            })
        }
        
        return
    }
    

    @IBAction func movingOnButton(_ sender: UIButton) {
        
        if (firstNameTextField.text?.isEmpty)! || (lastNameTextField.text?.isEmpty)! || (emailTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! || (confirmPasswordTextField.text?.isEmpty)! || (zipcodeTextField.text?.isEmpty)! || gender == nil {
            
            let textFieldAlert = UIAlertController(title: "Warning", message: "Not all information has been entered. Please complete all text fields", preferredStyle: .alert)
            textFieldAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(textFieldAlert, animated: true, completion: nil)
            
            shouldPerformSegue(withIdentifier: "movingOn") {
                
                return false
            }
            
            
        }
        else if ((firstNameTextField.text != nil) && (lastNameTextField.text != nil) && (emailTextField.text != nil) && (passwordTextField.text != nil) && (confirmPasswordTextField.text != nil) && (zipcodeTextField.text != nil) && gender != nil) {
            
            if let email = emailTextField.text, let pass = passwordTextField.text {
                if pass == confirmPasswordTextField.text {
                // Register the user with firebase
                Auth.auth().createUser(withEmail: email, password: pass, completion: { (User, Error) in
                    
                    // check that the user isn't nil
                    if User != nil && Error == nil {
                        
                        // set isFirstTimeSignIn = true;
                        let user = Auth.auth().currentUser
                        
                        // set isFirstTimeSignIn true once the user register
                        if let user = user
                        {
                            let uid = user.uid
                            let email = user.email
                            // save non-database information to database when register
                            
                            Firestore.firestore().document("Users/\(uid)/UserInfo/Logs").setData(["isFirstTimeSignIn" : true])
                            Firestore.firestore().document("Users/\(uid)/UserInfo/Profile").setData(["Email": email!])
                            
                            self.logRef = Firestore.firestore().document("Users/\(uid)/UserInfo/Logs")
                            self.logRef.setData(["isFirstTimeSignIn" : false])
                            // set "isFirstTimeSignIn" to false after testing
                            
                            // if the information is not entered, keep the original information (do nothing)
                            // if the information is entered, store it to the cloud
                            self.profileRef = Firestore.firestore().document("Users/\(uid)/UserInfo/Profile")
                            if self.firstNameTextField.text != ""
                            {
                                self.profileRef.setData(["First Name": self.firstNameTextField.text!], options: SetOptions.merge())
                            }
                            if self.lastNameTextField.text != ""
                            {
                                self.profileRef.setData(["Last Name": self.lastNameTextField.text!], options: SetOptions.merge())
                            }
                            if self.phoneNumTextField.text != ""
                            {
                                self.profileRef.setData(["Phone Number": self.phoneNumTextField.text!], options: SetOptions.merge())
                                
                            }
                            if self.zipcodeTextField.text != ""
                            {
                                
                                self.profileRef.setData(["Zip Code": self.zipcodeTextField.text!], options: SetOptions.merge())
                            }
                            if self.gender != nil
                            {
                                
                                self.profileRef.setData(["Gender" : self.gender], options: SetOptions.merge())
                            }
                            if self.birthdayString != nil
                            {
                                
                                self.profileRef.setData(["Birthday" : self.birthdayString], options: SetOptions.merge())
                            }
                            
                            // i need a zip code database link, the bio, country, and state are unnessacary only the zip is needed
                            
                        }
                        
                        // send the verification email
                        self.sendVerificationEmail()
                        // User is found, go to home screen
                        //self.performSegue(withIdentifier: "goHome", sender: self)
                        
                    }
                    else {
                        // Error: check error and show message
                        let registerError = UIAlertController(title: "Registration Error", message: "\(Error!.localizedDescription) Please try again. ", preferredStyle: .alert)
                        registerError.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(registerError, animated: true, completion: nil)
                        
                    }
                    
                    
                })
                }
            }
         
            shouldPerformSegue(withIdentifier: "movingOn") {
                
                return true
            }
            
        }
        
        
    }
    

    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func changeTextFieldStatus(value: UITextField) {
        
        value.layer.shadowColor = UIColor.black.cgColor
        value.layer.shadowOffset = CGSize(width: 2, height: 2)
        value.layer.shadowRadius = 5
        value.layer.shadowOpacity = 0.75
        value.layer.cornerRadius = 8
        value.layer.borderColor = UIColor.black.cgColor
        value.layer.borderWidth = 2.0
        
        
    }
    
    func changeLabelStatus(value: UILabel) {
        
        value.layer.shadowColor = UIColor.black.cgColor
        value.layer.shadowOffset = CGSize(width: 2, height: 2)
        value.layer.shadowRadius = 5
        value.layer.shadowOpacity = 0.75
        
    }
    
    
    
}

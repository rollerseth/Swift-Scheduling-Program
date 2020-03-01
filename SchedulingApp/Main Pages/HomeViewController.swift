//
//  HomeViewController.swift
//  SchedulingApp
//
//  Created by Seth Roller on 1/28/18.
//  Copyright © 2018 Seth Roller. All rights reserved.
//

import UIKit
import QuartzCore
import Firebase

class HomeViewController: UIViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var emailLabe: UILabel!
    @IBOutlet weak var passWordLabel: UILabel!
    @IBOutlet weak var skedgeTitleLabel: UILabel!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var forgetPass: UIButton!
    
    var isSignIn:Bool = true
    
    let transition = CircularTransition()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signUpButton.layer.cornerRadius = 8
        signInButton.layer.cornerRadius = 8
        
        changeLabelStatus(value: skedgeTitleLabel)
        changeLabelStatus(value: emailLabe)
        changeLabelStatus(value: passWordLabel)
        
        skedgeTitleLabel.layer.shadowColor = UIColor.white.cgColor
        emailLabe.layer.shadowColor = UIColor.black.cgColor
        passWordLabel.layer.shadowColor = UIColor.black.cgColor
        
        skedgeTitleLabel.layer.shadowColor = UIColor.darkGray.cgColor
        skedgeTitleLabel.layer.shadowRadius = 5
        skedgeTitleLabel.layer.shadowOpacity = 0.75
        skedgeTitleLabel.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        changButtonStatus(value: signInButton)
        changButtonStatus(value: signUpButton)
        
        forgetPass.layer.shadowColor = UIColor.white.cgColor
        forgetPass.layer.shadowRadius = 5
        forgetPass.layer.shadowOpacity = 0.75
        forgetPass.layer.shadowOffset = CGSize(width: 2, height: 2)
       
        changeTextField(value: emailTextField)
        changeTextField(value: passwordTextField)
        
    }
    
    /* this is my circle transition implemitation 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
            
            let secondVC = segue.destination as! HomePage
            secondVC.transitioningDelegate = self
            secondVC.modalPresentationStyle = .custom
            
        
   
     
    }
        
        func animationController(forPresented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning {
            
            transition.transtionMode = .present
            transition.startingPoint = signInButton.center
            transition.circleColor = signInButton.backgroundColor!
            
            return transition
            
        }
        
        func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            
            transition.transtionMode = .present
            transition.startingPoint = signInButton.center
            transition.circleColor = signInButton.backgroundColor!
            
            return transition
        }
        
    */

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
    
    func changeTextField(value: UITextField) {
        
        value.layer.cornerRadius = 8
        value.layer.borderColor = UIColor.black.cgColor
        value.layer.borderWidth = 2.0
        value.layer.shadowColor = UIColor.black.cgColor
        value.layer.shadowRadius = 5
        value.layer.shadowOpacity = 0.75
        value.layer.shadowOffset = CGSize(width: 2, height: 2)
        
    }
    
    func changButtonStatus(value: UIButton) {
        
        value.layer.shadowRadius = 5
        value.layer.shadowOpacity = 0.75
        value.layer.shadowOffset = CGSize(width: 2, height: 2)
        value.layer.borderColor = UIColor.black.cgColor
        value.layer.borderWidth = 1.5
        
    }
    
    
    func changeLabelStatus(value: UILabel) {
        
        value.layer.shadowRadius = 5
        value.layer.shadowOpacity = 0.75
        value.layer.shadowOffset = CGSize(width: 2, height: 2)
        
    }
    
    
    @IBAction func unwindSegue(_ sender: UIStoryboardSegue) {
        
        // if there is a user signed in
        if Auth.auth().currentUser != nil
        {
            // sign out the user and catch errors
            do
            {
                try Auth.auth().signOut()
                
                if Auth.auth().currentUser == nil
                {
                    // go to main Page
                   print("\n\nSuccessfully Signed Out!!!\n\n")
                    navigationController?.popViewController(animated: true)
                }
                
            }
            catch let signOutError as NSError
            {
                // Error Handling (Alert)
                let signOutErrorAlert = UIAlertController(title: "Sign-out Error", message: "\(signOutError) Please Try Again.", preferredStyle: .alert)
                signOutErrorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(signOutErrorAlert, animated: true, completion: nil)
            }
            catch
            {
                let unknownErrorAlert = UIAlertController(title: "Unknown Error", message: "Please Try Again.", preferredStyle: .alert)
                unknownErrorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(unknownErrorAlert, animated: true, completion: nil)
            }
        }
        else
        {
            // Alert: User has signed out
            let signOutErrorAlert = UIAlertController(title: "Sign-out Error", message: "User has signed out. Please go back to the login page.", preferredStyle: .alert)
            signOutErrorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(signOutErrorAlert, animated: true, completion: nil)
            
            
            
            
        }
        
        if (emailTextField.hasText == true && passwordTextField.hasText == true) {
            
            emailTextField.text?.removeAll()
            passwordTextField.text?.removeAll()
            
        }
        
    }
    
    @IBAction func signingInAction(_ sender: UIButton) {
    
        if let email = emailTextField.text, let pass = passwordTextField.text
        {
            // check if it's signin or register
            if isSignIn
            {
                // Sign in the user with Firebase
                Auth.auth().signIn(withEmail: email, password: pass, completion: { (User, Error) in
                    
                    // check that user isn't nil
                    if User != nil && Error == nil
                    {
                        // User has the correct credentials
                        if User!.isEmailVerified
                        {
                            // User is found, and Email address is verified, check if the user is signing in for the first time
                            let user = Auth.auth().currentUser
                            // set isFirstTimeSignIn False after the user fill in the information
                            if let user = user {
                                
                                let uid = user.uid
                                //Firestore.firestore().document("Users/\(uid)/UserInfo/Logs").setData(["isFirstTimeSignIn" : true])
                                
                                let docRef = Firestore.firestore().document("Users/\(uid)/UserInfo/Logs")
                                
                                docRef.getDocument { (document, error) in
                                    if let document = document
                                    {
                                        //print("Document data: \(document.data())")
                                        if document.data() == nil
                                        {
                                            docRef.setData(["isFirstTimeSignIn": true])
                                        }
                                    }
                                    else
                                    {
                                        print("Document does not exist")
                                        //docRef.setData(["isFirstTimeSignIn": true])
                                    }
                                }
                            }
                            
                            self.performSegue(withIdentifier: "signInSuccessSegue", sender: self)

                        }
                        else
                        {
                            let notVerifiedAlert = UIAlertController(title: "Email Not Verified", message: "Your Email is pending verification. Please check your email and verify your account.", preferredStyle: .alert)
                            notVerifiedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(notVerifiedAlert, animated: true, completion: nil)
                            
                            notVerifiedAlert.addAction(UIAlertAction(title: "Resend Verification Email", style: .default, handler:{ action in
                                self.sendVerificationEmail()}))
                            
                            do
                            {
                                try Auth.auth().signOut()
                            }
                            catch
                            {
                                // Handle Error
                            }
                       }
                        
                    }
                    else {
                        // Error: check error and show message
                        let signInError = UIAlertController(title: "Sign-in Error", message: "\(Error!.localizedDescription) Please try again. ", preferredStyle: .alert)
                        signInError.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(signInError, animated: true, completion: nil)
                    }
                })
            }
                
        }
        
    }

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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        // Dismiss the keyboard when the view is tapped on
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func forgetPasswordTapped(_ sender: Any) {
        
        let forgotPasswordAlert = UIAlertController(title: "Forgot Password?", message: "Don't worry. We can reset it for you. Just enter your email address here.", preferredStyle: .alert)
        forgotPasswordAlert.addTextField
            {
                (textField) in textField.placeholder = "Enter you email address"
        }
        forgotPasswordAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(forgotPasswordAlert, animated: true, completion: nil)
        
        forgotPasswordAlert.addAction(UIAlertAction(title: "Reset Password", style: .default, handler:{ (action) in
            let resetEmail = forgotPasswordAlert.textFields?.first?.text
            
            Auth.auth().sendPasswordReset(withEmail: resetEmail!, completion: { (Error) in
                if Error != nil
                {
                    let resetFailedAlert = UIAlertController(title: "Reset Failed", message: "Error: \(Error!.localizedDescription) Please try again. ", preferredStyle: .alert)
                    resetFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(resetFailedAlert, animated: true, completion: nil)
                }
                else
                {
                    let resetEmailSentAlert = UIAlertController(title: "Reset Email Sent", message: "A password reset email has been sent to your registered Email address successfully. Please check your Email and follow the instruction.", preferredStyle: .alert)
                    resetEmailSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(resetEmailSentAlert, animated: true, completion: nil)
                }
            })
            
        }))
        
    }
    

  
    
}


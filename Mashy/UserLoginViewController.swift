//
//  UserLoginViewController.swift
//  Mashy
//
//  Created by Amal Khaled on 11/4/17.
//  Copyright © 2017 amany. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class UserLoginViewController: UIViewController , GIDSignInUIDelegate ,GIDSignInDelegate{
    
    @IBOutlet var emailEditText: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet var passEditText: SkyFloatingLabelTextFieldWithIcon!
    
  
    
    var iconClick : Bool!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iconClick = true

        emailEditText.isLTRLanguage = false
        passEditText.isLTRLanguage = false

        emailEditText.iconText = "\u{f072}"
        passEditText.iconText = "\u{f023}"

        //Google Login
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        print("lola")

        if configureError != nil {
            print("we have error \(configureError)")
        }
        print("lola")

        GIDSignIn.sharedInstance().delegate = self

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UserLoginViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    override func viewDidAppear(_ animated: Bool) {
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signOut()
        GIDSignIn.sharedInstance().clientID = "439536779712-6ahg1bnhbuuf9p75beshaahduc820bio.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().signInSilently()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            
            //            UserController.currentActiveUser.FName = user.profile.givenName
            //            UserController.currentActiveUser.LName = user.profile.familyName
            //            UserController.currentActiveUser.pass = user.userID
            //            UserController.currentActiveUser.email = user.profile.email
            //            UserController.currentActiveUser.loginType = "G"
            //            UserController.usercontroller.LoginMedia("G", loginViewController: self)
            print("hi")
            AppDelegate.currentUser.email = user.profile.email
            AppDelegate.currentUser.pass = user.userID
            AppDelegate.currentUser.name = user.profile.givenName + user.profile.familyName
            print(AppDelegate.currentUser.email)
            print(AppDelegate.currentUser.pass)
            print(AppDelegate.currentUser.name)

            
            
        } else {
            print("amal zh2t")
            print("\(error.localizedDescription)")
        }
    }
    
    
    func sign(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
                withError error: NSError!) {
        // Perform any operations when the user disconnects from app here.
        // LogOut
    }

    @IBAction func loginButtonAction(_ sender: Any) {
        if validation() {
            AppDelegate.currentUser.email = emailEditText.text!
            AppDelegate.currentUser.pass = passEditText.text!
            Services.services.login(uiViewController: self)
        }
    }
    func validation()->Bool{
        var valid = true
        if emailEditText.text!.count == 0{
            emailEditText.errorMessage = "ادخل البريد الالكتروني الصحيح".localized()
            valid = false
        }
        else {
            emailEditText.errorMessage = ""
            valid = true

        }
        if passEditText.text!.count == 0{
            passEditText.errorMessage = "ادخل كلمه المرور".localized()
            valid = false
        }
        else {
            passEditText.errorMessage = ""
            valid = true
            
        }
        
        return valid
    }
    
    
    @IBAction func showPassword(_ sender: Any) {
        if(iconClick == true) {
            passEditText.isSecureTextEntry = false
            iconClick = false
        } else {
            passEditText.isSecureTextEntry = true
            iconClick = true
        }
    }
    @IBAction func forgetPassAction(_ sender: Any) {
        
        if emailEditText.text!.count == 0{
            emailEditText.errorMessage = "ادخل البريد الالكتروني الصحيح".localized()
        }
        else {
            emailEditText.errorMessage = ""
            AppDelegate.currentUser.email = emailEditText.text!
           Services.services.checkEmailForReset(uiViewController: self)
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

}

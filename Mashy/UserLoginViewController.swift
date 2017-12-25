//
//  UserLoginViewController.swift
//  Mashy
//
//  Created by Amal Khaled on 11/4/17.
//  Copyright © 2017 amany. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import FBSDKLoginKit

class UserLoginViewController: UIViewController {
    
    @IBOutlet var emailEditText: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet var passEditText: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnGoogleView: UIView!
    
    var iconClick : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iconClick = true
        emailEditText.isLTRLanguage = false
        passEditText.isLTRLanguage = false
        emailEditText.iconText = "\u{f072}"
        passEditText.iconText = "\u{f023}"
        emailEditText.text = "a@y.com"
      
       
        /*
        //Configure the Google Login
      
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        print("lola")

        if configureError != nil {
            print("we have error \(String(describing: configureError))")
        }
        print("lola")

        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().clientID = "439536779712-6ahg1bnhbuuf9p75beshaahduc820bio.apps.googleusercontent.com"
        
        */
        
        //Configure & Set Up the Facebook Login button method call
        configureFacebookLogin()
        
        
        
        //Tap Gesture to handle the Keyboard
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

        GIDSignIn.sharedInstance().signOut()
        GIDSignIn.sharedInstance().signInSilently()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        self.performSegue(withIdentifier: "forget_pass", sender: self)
//        performSegue(withIdentifier: "forget_pass", sender: self)
        
    }

     func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "test"{
//            let vc = segue.destination as! ForgetPassViewController
//            vc.isFromUserLogin = true
            //Data has to be a variable name in your RandomViewController
        }
    }
    //MARK: - Google Login Button

    @IBAction func googleSignInButtonAction(_ sender: Any) {
        
        let signIn = GIDSignIn.sharedInstance()
        signIn?.shouldFetchBasicProfile = true
        signIn?.shouldFetchBasicProfile = true
        signIn?.clientID = String.GooogleClientKey
        signIn?.uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    //MARK: - Facebook Login Button
    func configureFacebookLogin(){
        //----------------Facebook SDK Code Start -----------------------\\
        
//        if FBSDKAccessToken.current() != nil {
//        }

        
        let fbBtnRect:CGRect = CGRect.zero //CGRect(x: btnGoogleView.frame.origin.x, y: btnGoogleView.frame.origin.y + btnGoogleView.frame.size.height + 25, width: btnGoogleView.frame.size.width, height: btnGoogleView.frame.size.height - 10)
        let loginButton = FBSDKLoginButton.init(frame: fbBtnRect)
        
        loginButton.delegate = self
        loginButton.readPermissions = ["public_profile", "email", "user_friends"];
        view.addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
    
        let verticalConstraint = NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: btnGoogleView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 20)
        
        let heightConstraint = NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 44)
        
        let topLeftViewLeadingConstraint = NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal
            , toItem: btnGoogleView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        

        let topRightViewTrailingConstraint = NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal
            , toItem: btnGoogleView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        
        
    
        view.addConstraints([ verticalConstraint, heightConstraint,topLeftViewLeadingConstraint,topRightViewTrailingConstraint])
        
        //----------------Facebook SDK Code End -----------------------\\
    }

}

// MARK: - FBSDKLoginButtonDelegate

extension UserLoginViewController : FBSDKLoginButtonDelegate{
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        print("Facebook Result : \(result)")
        FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"first_name, last_name,email, picture.type(large)"]).start { (connection, result, error) -> Void in
            let responseResult = result as! NSDictionary
            let strEmail: String = (responseResult.object(forKey: "email") as? String)!
            let strFirstName: String = (responseResult.object(forKey: "first_name") as? String)!

            AppDelegate.currentUser.email = strEmail
            AppDelegate.currentUser.pass = ""
            AppDelegate.currentUser.name = strFirstName
    
            Services.services.checkEmailExistOrNot(uiViewController: self, email:strEmail)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        let loginManager:FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
    }
}

//MARK: - GIDSignInDelegate

extension UserLoginViewController:GIDSignInDelegate,GIDSignInUIDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if (error == nil) {
            print("hi")
            AppDelegate.currentUser.email = user.profile.email
            AppDelegate.currentUser.pass = ""
            AppDelegate.currentUser.name = user.profile.givenName + " "+user.profile.familyName
            
            Services.services.checkEmailExistOrNot(uiViewController: self, email:AppDelegate.currentUser.email)

        } else {
            print("amal zh2t")
            print("\(error.localizedDescription)")
        }
    }
    

}

extension String {
    static let GooogleClientKey = "439536779712-6ahg1bnhbuuf9p75beshaahduc820bio.apps.googleusercontent.com"
}

//
//  GetEmailViewController.swift
//  Mashy
//
//  Created by Amal Khaled on 11/3/17.
//  Copyright © 2017 amany. All rights reserved.
//

import UIKit
import Toast_Swift
import SkyFloatingLabelTextField

class UserEmailViewController: UIViewController  {
    
    @IBOutlet var emailEditText: SkyFloatingLabelTextFieldWithIcon!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailEditText.isLTRLanguage = false

        emailEditText.iconText = "\u{f072}" 

        // Do any additional setup after loading  as! GIDSignInDelegatethe view.
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        if (isValidEmail(testStr: emailEditText.text!) && emailEditText.text!.count > 0){
            emailEditText.errorMessage = ""
            AppDelegate.currentUser.email = emailEditText.text!
            Services.services.checkEmail(uiViewController: self)
        }
        else {
            emailEditText.errorMessage = "الايميل غير صحيح".localized()

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

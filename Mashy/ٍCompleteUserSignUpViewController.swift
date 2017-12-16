//
//  ٍCompleteUserSignUpViewController.swift
//  Mashy
//
//  Created by Amal Khaled on 11/3/17.
//  Copyright © 2017 amany. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class CompleteUserSignUpViewController: UIViewController  {

    @IBOutlet var rePassEditText: SkyFloatingLabelTextFieldWithIcon!
   
    @IBOutlet var passEditText: SkyFloatingLabelTextFieldWithIcon!
    override func viewDidLoad() {
        super.viewDidLoad()
        rePassEditText.isLTRLanguage = false
        passEditText.isLTRLanguage = false

        rePassEditText.iconText = "\u{f023}"
        passEditText.iconText = "\u{f023}"

        
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
    func validation()-> Bool{
        if (rePassEditText.text! != passEditText.text! || passEditText.text!.count == 0){
            rePassEditText.errorMessage = "كلمه المرور غير متطابقه".localized()
            return false
        }
        rePassEditText.errorMessage = ""
        

        return true
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func finishButtonAction(_ sender: Any) {
        if validation(){
            AppDelegate.currentUser.pass = passEditText.text!
            Services.services.SIGNUP(uiViewController: self)
            //check email from services
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

//
//  ForgetPassViewController.swift
//  Mashy
//
//  Created by Amal Khaled on 11/15/17.
//  Copyright © 2017 amany. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ForgetPassViewController: UIViewController {

    @IBOutlet var phoneEditText: SkyFloatingLabelTextFieldWithIcon!
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneEditText.isLTRLanguage = false
        
        phoneEditText.iconText = "\u{f095}"
        
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ForgetPassViewController.dismissKeyboard))
        
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
    

    @IBAction func nextButtonClicked(_ sender: Any) {
        if (phoneEditText.text!.count != 0){
            phoneEditText.errorMessage = ""
            AppDelegate.currentDriver.phoneNumber = phoneEditText.text!
            let code = String( Int(arc4random_uniform(8999) + 1000))
            AppDelegate.code = code
            Services.services.sendCode(uiViewController: self, code: code)

            
        }
        else {
            phoneEditText.errorMessage = "ادخل رقم الهاتف"
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

//
//  PhoneViewController.swift
//  Mashy
//
//  Created by Mukesh Lokare on 20/12/17.
//  Copyright © 2017 amany. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class PhoneViewController: UIViewController {

    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var textFieldPhone: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblSocialEmail: UILabel!
    
    //MARK:- Next Button Action

    override func viewDidLoad() {
        super.viewDidLoad()

        textFieldPhone.isLTRLanguage = false
        textFieldPhone.iconText = "\u{f095}"
        lblPhone.text = "enter_your_phone".localized()
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ForgetPassViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    //MARK:- Next Button Action
    @IBAction func nextButtonClicked(_ sender: Any) {
        
        btnNext.isUserInteractionEnabled = false
        
        if textFieldPhone.text!.contains("+") {
            if textFieldPhone.text!.count == 0{
                textFieldPhone.errorMessage = "ادخل البريد الالكتروني الصحيح".localized()
                self.btnNext.isUserInteractionEnabled = true
            }else {
                textFieldPhone.errorMessage = ""
                var phoneStr:String = textFieldPhone.text!
                let phoneStrTrimmed = phoneStr.removePlus
                AppDelegate.currentUser.phone = phoneStrTrimmed
                Services.services.checkPhone(uiViewController: self, completion_callback: { (result) in
                    
                    if result != "failed"{
                        let code = String( Int(arc4random_uniform(8999) + 1000))
                        AppDelegate.code = Comman().convertToEnglish(string: code)
                        print("OTP Code : \(code)")
                        Services.services.sendCode(uiViewController: self, code: code, numbers:AppDelegate.currentUser.phone,loginType:2)
                        self.btnNext.isUserInteractionEnabled = true
                    }else{
                        let code = String( Int(arc4random_uniform(8999) + 1000))
                        AppDelegate.code = Comman().convertToEnglish(string: code)
                        print("OTP Code : \(code)")
                        Services.services.sendCode(uiViewController: self, code: code, numbers:AppDelegate.currentUser.phone,loginType:2)
                        self.btnNext.isUserInteractionEnabled = true

                    }
                })
            }
        }else{
            textFieldPhone.errorMessage = " تم ادخال رقم غير صحيح"
            self.btnNext.isUserInteractionEnabled = true
        }
        
    }
    //MARK:- Back Button Action

    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }

}


//
//  CodeRegisterViewController.swift
//  Mashy
//
//  Created by Mukesh Lokare on 20/12/17.
//  Copyright © 2017 amany. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class CodeRegisterViewController: UIViewController {

    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var textFieldCode: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var lblCode: UILabel!
    
    @IBOutlet weak var btnResendCode: UIButton!
   
    //MARK:- Next Button Action

    override func viewDidLoad() {
        super.viewDidLoad()
       
        textFieldCode.isLTRLanguage = false
        lblCode.text = "enter_code".localized()

        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CodeViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func resendCodeButtonClicked(_ sender: Any) {
        
        let code = String( Int(arc4random_uniform(8999) + 1000))
        AppDelegate.code = Comman().convertToEnglish(string: code)
        print("Resend Code : \(code)")
        Services.services.sendCode(uiViewController: self, code: code, numbers:"",loginType:2)
    }
    //MARK:- Next Button Action

    @IBAction func nextButtonClicked(_ sender: Any) {
        btnNext.isUserInteractionEnabled = false

        if (textFieldCode.text! == AppDelegate.code){
            textFieldCode.errorMessage = ""
            Services.services.insertUser(uiViewController: self)
            btnNext.isUserInteractionEnabled = true

        }
        else {
            textFieldCode.errorMessage = "الكود غير صحيح"
            btnNext.isUserInteractionEnabled = true
        }
    }
    
    //MARK:- Back Button Action
    @IBAction func backButtonClicked(_ sender: Any) {
        
     self.dismiss(animated: false, completion: nil)
    }
}

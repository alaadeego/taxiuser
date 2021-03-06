//
//  CodeViewController.swift
//  Mashy
//
//  Created by Amal Khaled on 11/15/17.
//  Copyright © 2017 amany. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class CodeViewController: UIViewController {

    @IBOutlet var codeEditText: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var lblToDisplayCode: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        codeEditText.isLTRLanguage = false
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CodeViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        lblToDisplayCode.text = AppDelegate.code
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
    
    @IBAction func nextButtonAction(_ sender: Any) {
        if (codeEditText.text! == AppDelegate.code){
            codeEditText.errorMessage = ""
            performSegue(withIdentifier: "new_pass", sender: self)
        }
        else {
            codeEditText.errorMessage = "الكود غير صحيح"
        }
    }
    
    @IBAction func resendCodeButton(_ sender: Any) {
        
        let code = String( Int(arc4random_uniform(8999) + 1000))
        AppDelegate.code = Comman().convertToEnglish(string: code)
        Services.services.sendCode(uiViewController: self, code: code, numbers:"",loginType:1)        
    }
}

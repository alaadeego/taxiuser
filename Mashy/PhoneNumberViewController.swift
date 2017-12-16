//
//  PhoneNumberViewController.swift
//  Mashy
//
//  Created by Amal Khaled on 11/8/17.
//  Copyright © 2017 amany. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class PhoneNumberViewController: UIViewController {

    @IBOutlet var errorLable: UILabel!
    @IBOutlet var numberEditText: SkyFloatingLabelTextFieldWithIcon!
    override func viewDidLoad() {
        super.viewDidLoad()
        numberEditText.isLTRLanguage = false
        
        numberEditText.iconText = "\u{f095}"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextAction(_ sender: Any) {
        errorLable.isHidden = true
        if (numberEditText.text!.count != 0){
            numberEditText.errorMessage = ""
            AppDelegate.currentDriver.phoneNumber = numberEditText.text!
            Services.services.checkDriverPhone(uiViewController: self)
            
        }
        else {
            numberEditText.errorMessage = "ادخل رقم الهاتف"
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

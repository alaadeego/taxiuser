//
//  DriverPasswordViewController.swift
//  Mashy
//
//  Created by Amal Khaled on 11/9/17.
//  Copyright © 2017 amany. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class DriverPasswordViewController: UIViewController {
    @IBOutlet var sPassEditText: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet var fPassEditText: SkyFloatingLabelTextFieldWithIcon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sPassEditText.isLTRLanguage = false
        fPassEditText.isLTRLanguage = false
        
        sPassEditText.iconText = "\u{f023}"
        fPassEditText.iconText = "\u{f023}"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        if (sPassEditText.text!.count != 0 && fPassEditText.text! == sPassEditText.text!){
            sPassEditText.errorMessage = ""
            AppDelegate.currentDriver.pass = sPassEditText.text!
            performSegue(withIdentifier: "driver_lincese", sender: self)
            
        }
        else {
            sPassEditText.errorMessage = "كلمه المرور غير متطابقه".localized()
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

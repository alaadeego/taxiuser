//
//  DriverIDViewController.swift
//  Mashy
//
//  Created by Amal Khaled on 11/8/17.
//  Copyright © 2017 amany. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class DriverIDViewController: UIViewController {

    @IBOutlet var IDEditText: SkyFloatingLabelTextFieldWithIcon!
    override func viewDidLoad() {
        super.viewDidLoad()
        IDEditText.isLTRLanguage = false
        
        IDEditText.iconText = "\u{f2c3}"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func nextButtonAction(_ sender: Any) {
        if (IDEditText.text!.count != 0){
            IDEditText.errorMessage = ""
            AppDelegate.currentDriver.ID = IDEditText.text!
            performSegue(withIdentifier: "driverPhone", sender: self)
            
        }
        else {
            IDEditText.errorMessage = "ادخل رقم الهويه"
        }
    }
    
}

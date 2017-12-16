//
//  DriverNameViewController.swift
//  Mashy
//
//  Created by Amal Khaled on 11/8/17.
//  Copyright © 2017 amany. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class DriverNameViewController: UIViewController {

    @IBOutlet var nameEditText: SkyFloatingLabelTextFieldWithIcon!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameEditText.isLTRLanguage = false
        
        nameEditText.iconText = "\u{f007}"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func nextButtinAction(_ sender: Any) {
        if (nameEditText.text!.count != 0){
            nameEditText.errorMessage = ""
            AppDelegate.currentDriver.name = nameEditText.text!
            performSegue(withIdentifier: "driverID", sender: self)
            
        }
        else {
            nameEditText.errorMessage = "ادخل الاسم"
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

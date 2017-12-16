//
//  NewPassViewController.swift
//  Mashy
//
//  Created by Amal Khaled on 11/15/17.
//  Copyright © 2017 amany. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class NewPassViewController: UIViewController {

    @IBOutlet var repassEditText: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet var passEditText: SkyFloatingLabelTextFieldWithIcon!
    override func viewDidLoad() {
        super.viewDidLoad()
        repassEditText.isLTRLanguage = false
        passEditText.isLTRLanguage = false
        
        repassEditText.iconText = "\u{f023}"
        passEditText.iconText = "\u{f023}"
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewPassViewController.dismissKeyboard))
        
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
    
    @IBAction func nextButtonAction(_ sender: Any) {
        if validation(){
            AppDelegate.currentUser.pass = passEditText.text!
Services.services.resetPass(uiViewController: self)
        }
    }
    func validation()-> Bool{
        if (repassEditText.text! != passEditText.text! || passEditText.text!.count == 0){
            repassEditText.errorMessage = "كلمه المرور غير متطابقه".localized()
            return false
        }
        repassEditText.errorMessage = ""
        
        
        return true
        
        
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

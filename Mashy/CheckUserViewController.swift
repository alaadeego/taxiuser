//
//  CheckUserViewController.swift
//  Mashy
//
//  Created by Amal Khaled on 12/3/17.
//  Copyright © 2017 amany. All rights reserved.
//

import UIKit

class CheckUserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func nextButtonClicked(_ sender: Any) {
        if let email:String = AppDelegate.defaults.string(forKey: "email" ){
            if let pass:String = AppDelegate.defaults.string(forKey: "pass" ){
                AppDelegate.currentUser.email = email
                AppDelegate.currentUser.pass = pass
                
                Services.services.login(uiViewController: self)
                
            }
            else {
                performSegue(withIdentifier: "login", sender: self)
            }
        }
        else {
            performSegue(withIdentifier: "login", sender: self)
            
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

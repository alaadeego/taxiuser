//
//  ProfileViewController.swift
//  Mashy
//
//  Created by Amal Khaled on 12/7/17.
//  Copyright © 2017 amany. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var headerEmailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //profile Date
        emailLabel.text = AppDelegate.currentUser.email
        phoneLabel.text = AppDelegate.currentUser.phone
        headerEmailLabel.text = AppDelegate.currentUser.email
        
        
        
        //back
        let backButton: UIBarButtonItem = UIBarButtonItem(title: "رجوع" , style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func back(){
        performSegue(withIdentifier: "back", sender: self)
        
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

}

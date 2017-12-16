//
//  FinshSignUpViewController.swift
//  Mashy
//
//  Created by Amal Khaled on 11/4/17.
//  Copyright © 2017 amany. All rights reserved.
//

import UIKit

class FinshSignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
            self.performSegue(withIdentifier: "login", sender: self)        })
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

}

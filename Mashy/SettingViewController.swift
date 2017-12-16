//
//  SettingViewController.swift
//  Mashy
//
//  Created by Amal Khaled on 12/9/17.
//  Copyright © 2017 amany. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet var notificationSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        notificationSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        
        notificationSwitch.addTarget(self, action: #selector(SettingViewController.changeNotificationStat), for: .touchUpInside)
        
    }
    func changeNotificationStat(){
        print("hi there")
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

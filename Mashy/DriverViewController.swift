//
//  DriverViewController.swift
//  Mashy
//
//  Created by Amal Khaled on 11/30/17.
//  Copyright © 2017 amany. All rights reserved.
//

import UIKit
import HCSStarRatingView
import SDWebImage

class DriverViewController: UIViewController {

    @IBOutlet var duration: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var rating: HCSStarRatingView!
    @IBOutlet var profilePic: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let driver = AppDelegate.currentDriver
        
        print(driver.name)
    
        
        nameLabel.text = driver.name
        guard let n = NumberFormatter().number(from: driver.rating) else { return }
        
        rating.value = CGFloat(n)
        duration.text = AppDelegate.currentTrip.driverFar
        
        
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
//        profilePic.layer.masksToBounds = false
        self.profilePic.layer.cornerRadius = self.profilePic.frame.size.height / 2;
        self.profilePic.layer.masksToBounds = true
//        profilePic.layer.borderWidth=1.0
//        profilePic.layer.masksToBounds = false
//        profilePic.layer.borderColor = UIColor.white.cgColor
//        profilePic.layer.cornerRadius = profilePic.frame.size.height/2
//        profilePic.clipsToBounds = true
        profilePic.sd_setImage(with: URL(string: AppDelegate.currentDriver.profilePic), placeholderImage: UIImage(named: "placeholder.png"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
        //        if let call = detail.value(forKey: "Phone") as? String,
        //            let url = URL(string: "tel://\(call)"),
        //            UIApplication.shared.canOpenURL(url) {
        //            UIApplication.shared.open(url)
        //        }


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

    @IBAction func cancelAction(_ sender: Any) {
        Services.services.cancelTripReasons(uiViewController: self)
    }
   
    
    @IBAction func callAction(_ sender: Any) {
//            let url = URL(string: "tel://\(AppDelegate.currentDriver.phoneNumber)")
//            UIApplication.shared.canOpenURL(url) {
//            UIApplication.shared.open(url)
        if let url = URL(string: "tel://\(AppDelegate.currentDriver.phoneNumber)"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
        }
        performSegue(withIdentifier: "track_driver", sender: self)
    }
    
}

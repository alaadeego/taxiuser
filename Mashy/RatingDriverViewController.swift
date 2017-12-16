//
//  RatingDriverViewController.swift
//  Mashy
//
//  Created by Amal Khaled on 12/9/17.
//  Copyright © 2017 amany. All rights reserved.
//

import UIKit
import HCSStarRatingView


class RatingDriverViewController: UIViewController {
    @IBOutlet var Rating: HCSStarRatingView!
    var ratingValue = "0"
    @IBOutlet var driverName: UILabel!
    @IBOutlet var driverPic: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let driver = AppDelegate.currentDriver
        
        driverName.text = driver.name

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func rateDriver(_ sender: Any) {
        Services.services.ratingDriver(uiViewController: self, rate: ratingValue)
    }
    override func viewDidLayoutSubviews() {
        //        profilePic.layer.masksToBounds = false
        self.driverPic.layer.cornerRadius = self.driverPic.frame.size.height / 2;
        self.driverPic.layer.masksToBounds = true
        //        profilePic.layer.borderWidth=1.0
        //        profilePic.layer.masksToBounds = false
        //        profilePic.layer.borderColor = UIColor.white.cgColor
        //        profilePic.layer.cornerRadius = profilePic.frame.size.height/2
        //        profilePic.clipsToBounds = true
        driverPic.sd_setImage(with: URL(string: AppDelegate.currentDriver.profilePic), placeholderImage: UIImage(named: "placeholder.png"))
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func takeRatingValue(_ sender: Any) {
        ratingValue = String(describing: Rating.value)
        print(ratingValue)
    }
    
    
}

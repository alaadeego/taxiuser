//
//  RightMenuViewController.swift
//  SSASideMenuExample
//
//  Created by Sebastian Andersen on 06/03/15.
//  Copyright (c) 2015 Sebastian Andersen. All rights reserved.
//

import Foundation
import UIKit
import Localize_Swift
import Haneke

class RightMenuViewController: UIViewController {
    
    @IBOutlet weak var tablemenu: UITableView!
    var Titles_menu:[String]?
    var Image_menu:[UIImage]?

    override func viewWillAppear(_ animated: Bool) {
        Titles_menu = [
//            "userProfile".localized(),
        "payment".localized(),
        "history".localized(),
        "Wallet".localized(),
        "coupon".localized(),
        "settings".localized(),
        "shareApp".localized()]

        Image_menu = [#imageLiteral(resourceName: "pay"),#imageLiteral(resourceName: "pervious"),#imageLiteral(resourceName: "wallet"),#imageLiteral(resourceName: "coupon"),#imageLiteral(resourceName: "settingorange"),#imageLiteral(resourceName: "share")]

        tablemenu.delegate=self
        tablemenu.dataSource=self
        tablemenu.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        
    }
    override func viewDidLoad() {

        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector:#selector(RightMenuViewController.UpdateMenuData) , name: NSNotification.Name(rawValue: "ReloadMenuData"), object: nil)

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


// MARK : TableViewDataSource & Delegate Methods

extension RightMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (Titles_menu!.count+1)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if (indexPath.row == 0)
            {
                return 150
            }
            else
            {
                return 55
            }
    }


    func UpdateMenuData(){
        self.tablemenu.reloadData()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell:UITableViewCell?

        if (indexPath.row == 0)
        {

            let cell:userCell  = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! userCell


//            let defaults:UserDefaults = (UserDefaults.standard)
//            if let testnilobject  = defaults.object(forKey: "nameuser") {
//                cell.user_title.text = testnilobject as? String
//            }
//            else
//            {
//                cell.user_title.text = "usernamelabel".localized()
//            }
//            if let testnilobject  = defaults.object(forKey: "UserPhoto") {
//                let url : String = testnilobject as! String
//                let urlStr : String = url.addingPercentEscapes(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
//                let ImageURL : URL = URL(string: urlStr as String)!
//                cell.user_image.hnk_setImageFromURL(ImageURL)
//            }
//            cell.user_image.layer.cornerRadius=37.5
//            cell.user_image.clipsToBounds=true


            cell.user_title.text = AppDelegate.currentUser.email



            return cell
        }

        else {

            let cell:menuCell  = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! menuCell

            //cell.backgroundColor = UIColor.grayColor()
            cell.menu_title.text = Titles_menu?[indexPath.row-1]
            cell.menu_image.image = Image_menu?[indexPath.row-1]


            return cell


        }


    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "user_profile")
            let rvc:SWRevealViewController = self.revealViewController() as SWRevealViewController
            rvc.pushFrontViewController(vc, animated: true)

            

            break
            
        case 1:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "payment_menu")
            let rvc:SWRevealViewController = self.revealViewController() as SWRevealViewController
            rvc.pushFrontViewController(vc, animated: true)
            break
        case 2:
           
            Services.services.callToGetUserTrips(uiViewController: AppDelegate.viewController, completion_callback: { (result) in
                var trips :Array = [Trip]()

                if (result["result"] as? String) != nil {
                    self.view.makeToast("البريد الالكتروني صحيح".localized())
                }
                else if let check = result["result"] as? NSArray {
                    
                    for i in 0 ..< check.count {
                        let userTrip = check[i] as? NSDictionary
                        trips.append(Trip(end: userTrip!["End"] as! String,price: userTrip!["Price"] as! String,start: userTrip!["Start"] as! String,time: userTrip!["Time"] as! String,distance: userTrip!["Distance"] as! String))
                    }
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "trips")as! TripsViewController
                    vc.trips = trips

                    let rvc:SWRevealViewController = self.revealViewController() as SWRevealViewController
                    rvc.pushFrontViewController(vc, animated: true)
                    
                }
                
            })
            break
        case 5:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "setting_menu")
            let rvc:SWRevealViewController = self.revealViewController() as SWRevealViewController
            rvc.pushFrontViewController(vc, animated: true)
            
            break
        case 6:
            self.revealViewController().revealToggle(animated: true)

            let activityVC = UIActivityViewController(activityItems: ["https://www.google.com.eg/"], applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = self.view
            self.present(activityVC , animated: true,completion: nil)
            
            break
            
        default:
            break
        }
        
        
    }

}


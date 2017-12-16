//
//  LookingForDriversViewController.swift
//  Mashy
//
//  Created by Amal Khaled on 11/29/17.
//  Copyright © 2017 amany. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation



class LookingForDriversViewController: UIViewController {
    
    //fireBase
    var ref: FIRDatabaseReference?


    override func viewDidLoad() {
        super.viewDidLoad()

        //firebase
        ref = FIRDatabase.database().reference()
        checkacceptance()
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    //firebase
    func checkacceptance(){
        let trip = AppDelegate.currentTrip
        ref?.child("Users").child(AppDelegate.currentUser.ID + "User").observe(.value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let request =  value?["Request"] as? String ?? ""
            
            if (request.characters.first == "o"){
                let index = request.index(request.startIndex, offsetBy: 3)
                let driverEmail = request.suffix(from: index)
                print("///////////////////////////")
                AppDelegate.currentDriver.email = String(driverEmail)
                Services.services.getDriverData(uiViewController: self)
//                print(driverEmail)
            }
            else if (request.characters.first == "n"){
                self.carClicked(type: trip.carType)
                
            }

            
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    //firebase
    func carClicked(type :String){
        let trip = AppDelegate.currentTrip
        trip.distance = "-1"
        
        ref?.child(type).observe(.childAdded, with: { (snapshot) in

            let value = snapshot.value as? NSDictionary

            let driver = snapshot.key
            let lat =  value?["Lat"] as? String ?? ""
            let long = value?["Longt"] as? String ?? ""
            let noti = value?["Notf"] as? String ?? ""
            let driverName = value?["Name"] as? String ?? ""
            
            if (noti == "0" && !AppDelegate.bestDrivers.contains(driver)){

                let latD = Double (lat)!
                let longD = Double (long)!

                let d = self.calDistance(clat: latD, clon: longD, dlat: Double (trip.cLat)!, dlon: Double (trip.cLon)!)

                if (trip.distance == "-1"){
                    
                    trip.distance = self.calDistance(clat: latD, clon: longD, dlat: Double (trip.cLat)!, dlon: Double (trip.cLon)!)
                    trip.bestDriver = driver
                    trip.driverName = driverName
                }
                else {
                    let d = self.calDistance(clat: latD, clon: longD, dlat: Double (trip.cLat)!, dlon: Double (trip.cLon)!)
                    
                    if (Double (d)! < Double(trip.distance)!){
                        trip.distance  = d
                        trip.bestDriver = driver
                        trip.driverName = driverName
                    }
                }
                print(trip.distance)
            }
            print(trip.bestDriver)
            if (trip.bestDriver != ""){
                let post = ["Notf": AppDelegate.currentUser.ID + "User" , "UserAddress": trip.cTitle ,"UserLat": trip.dLat ,"UserLongt": trip.dLon]
                
                self.ref?.child(trip.carType).child(trip.bestDriver).updateChildValues(post )
            }
            AppDelegate.bestDrivers.append(trip.bestDriver)

        }) { (error) in
            print(error.localizedDescription)
        }
       

    }

    func calDistance(clat : Double,clon : Double,dlat : Double,dlon : Double)-> String{
        let coordinate0 = CLLocation(latitude: dlat, longitude: dlon)
        let coordinate1 = CLLocation(latitude:clat, longitude: clon)
        return  String (Int (coordinate0.distance(from: coordinate1)/1000))
        
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

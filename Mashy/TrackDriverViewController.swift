//
//  TrackDriverViewController.swift
//  Mashy
//
//  Created by Amal Khaled on 12/9/17.
//  Copyright © 2017 amany. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase


class TrackDriverViewController: UIViewController ,GMSMapViewDelegate{

    @IBOutlet var dLocation: UILabel!
    @IBOutlet var cLocation: UILabel!
    @IBOutlet var Map: GMSMapView!
    
    //fireBase
    var ref: FIRDatabaseReference?
    var marker = GMSMarker()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let trip = AppDelegate.currentTrip
        
        //firebase
        ref = FIRDatabase.database().reference()

        
        let camera = GMSCameraPosition.camera(withLatitude: Double (trip.cLat)!, longitude:  Double (trip.cLon)!, zoom: 12)
        Map.animate(to: camera)

        
        let map = GMSMapView.map(withFrame: .zero, camera: camera)
        map.delegate = self
        
        self.Map.delegate = self
        self.Map.isMyLocationEnabled = true
        self.Map.settings.myLocationButton = true
        self.Map.isIndoorEnabled = true
        
        
        dLocation.text = trip.dSubTilite
        cLocation.text = "موقعك الحالي: " + trip.cTitle
        
        
        //draw line
        Services.services.drawPath(clat:trip.cLat, clon: trip.cLon, dlat: trip.dLat, dlon: trip.dLon , Map: Map)
        
        
        
        
        //distination marker
        let position = CLLocationCoordinate2DMake(Double (trip.dLat)!, Double (trip.dLon)!)
        let marker = GMSMarker(position: position)
        marker.map = self.Map
        
        //trackDriver
        trackDriver()
        
        //rate Driver
        // Do any additional setup after loading the view.
        tripEnded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func trackDriver(){
        let trip = AppDelegate.currentTrip
        ref?.child(trip.carType).child(trip.bestDriver).observe(.value, with: { (snapshot) in
            self.marker.map = nil

            let value = snapshot.value as? NSDictionary
            
            let lat =  Double( value?["Lat"] as? String ?? "")!
            
            let long =  Double(value?["Longt"] as? String ?? "")!
            
            let camera = GMSCameraPosition.camera(withLatitude:lat, longitude:  long, zoom: 20)
            self.Map.animate(to: camera)

            
            let position = CLLocationCoordinate2DMake( lat, long)
            self.marker = GMSMarker(position: position)
            
            self.marker.iconView = UIImageView(image : UIImage(named: trip.carImage)!)
            
            self.marker.map = self.Map
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }

    func tripEnded(){
        let trip = AppDelegate.currentTrip
        ref?.child("Users").child(AppDelegate.currentUser.ID + "User").observe(.value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let request =  value?["Request"] as? String ?? ""
            
            if (request.characters.first == "e"){
//                let index = request.index(request.startIndex, offsetBy: 4)
//                let driverEmail = request.suffix(from: index)
//                print("//////////////driverEmail/////////////")
//                AppDelegate.currentDriver.email = String(driverEmail)
//                Services.services.getDriverData(uiViewController: self)
                //                print(driverEmail)
                self.performSegue(withIdentifier: "gotorate", sender: self)
                
                
            }
           
            
            
            
        }) { (error) in
            print(error.localizedDescription)
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

//
//  RideTypeViewController.swift
//  Mashy
//
//  Created by Amal Khaled on 11/23/17.
//  Copyright © 2017 amany. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Firebase
import FirebaseDatabase



class RideTypeViewController: UIViewController ,GMSMapViewDelegate   {

    @IBOutlet var carType: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var Map: GMSMapView!
    @IBOutlet var distinationLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    
    @IBOutlet var ecoCarButton: UIButton!
    
    @IBOutlet var loyCarButton: UIButton!
    @IBOutlet var speCarButton: UIButton!
    //cars marker
    var marker = GMSMarker()
    var Blat :Double = 0.0
    var Blong : Double = 0.0
    
    //fireBase
    var ref: FIRDatabaseReference?

    
    //map
//    var userlocation:CLLocation = CLLocation()
//    var locationManager:CLLocationManager!



    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let trip = AppDelegate.currentTrip
        
        //firebase
        ref = FIRDatabase.database().reference()


        //map
//        locationManager=CLLocationManager()
//
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.startUpdatingLocation()
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.distanceFilter = kCLDistanceFilterNone
//        locationManager.delegate = self
//        userlocation = CLLocation()

        let camera = GMSCameraPosition.camera(withLatitude: Double (trip.cLat)!, longitude:  Double (trip.cLon)!, zoom: 12)
        Map.animate(to: camera)
        
        
        let map = GMSMapView.map(withFrame: .zero, camera: camera)
        map.delegate = self
        
        self.Map.delegate = self
        self.Map.isMyLocationEnabled = true
        self.Map.settings.myLocationButton = true
        self.Map.isIndoorEnabled = true
        
    
        distinationLabel.text = trip.dSubTilite
        locationLabel.text = "موقعك الحالي: " + trip.cTitle
        
     //Draw Line
        Services.services.drawPath(clat:trip.cLat, clon: trip.cLon, dlat: trip.dLat, dlon: trip.dLon , Map: Map)
        
    //distination marker
        let position = CLLocationCoordinate2DMake(Double (trip.dLat)!, Double (trip.dLon)!)
        let marker = GMSMarker(position: position)
        marker.map = self.Map
            
        
        self.carClicked(type: "Economic", img: "carblue")
        
        //Date
        let timestamp = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .short)
        timeLabel.text = timestamp


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
    
    
    @IBAction func loyCarButtonClicked(_ sender: Any) {
        AppDelegate.currentTrip.distance = "-1"
        AppDelegate.currentTrip.carType = "Rioyal"
        AppDelegate.currentTrip.carImage = "caryellow"

        carType.text = "ملكيه"
        carClicked(type: "Rioyal", img: "caryellow")
        ecoCarButton.setBackgroundImage(UIImage(named: "careconomyhide")!, for: .normal)
        speCarButton.setBackgroundImage(UIImage(named: "specialhide")!, for: .normal)
        loyCarButton.setBackgroundImage(UIImage(named: "royal")!, for: .normal)

    }
    @IBAction func speCarButtonClicked(_ sender: Any) {
        AppDelegate.currentTrip.distance = "-1"
        AppDelegate.currentTrip.carType = "Special"
        AppDelegate.currentTrip.carImage = "cargreen"

        carType.text = "مميزه"
        carClicked(type: "Special", img: "cargreen")
        ecoCarButton.setBackgroundImage(UIImage(named: "careconomyhide")!, for: .normal)
        speCarButton.setBackgroundImage(UIImage(named: "special")!, for: .normal)
        loyCarButton.setBackgroundImage(UIImage(named: "royalhide")!, for: .normal)

    }
    @IBAction func ecoCarButtonClicked(_ sender: Any) {
        AppDelegate.currentTrip.distance = "-1"
        AppDelegate.currentTrip.carType = "Economic"
        AppDelegate.currentTrip.carImage = "carblue"

        carType.text = "افتصاديه"
        carClicked(type: "Economic", img: "carblue")
        ecoCarButton.setBackgroundImage(UIImage(named: "careconomy")!, for: .normal)
        speCarButton.setBackgroundImage(UIImage(named: "specialhide")!, for: .normal)
        loyCarButton.setBackgroundImage(UIImage(named: "royalhide")!, for: .normal)

    }
    
    @IBAction func NextClicked(_ sender: Any) {
        AppDelegate.bestDrivers.append(AppDelegate.currentTrip.bestDriver)
        performSegue(withIdentifier: "schedule", sender: self)
    }
    
    func carClicked(type :String , img : String){
        marker.map = nil
        let trip = AppDelegate.currentTrip
        ref?.child(type).observe(.childAdded, with: { (snapshot) in
     
            let value = snapshot.value as? NSDictionary
          
            let driver = snapshot.key
            let lat =  value?["Lat"] as? String ?? ""
            let long = value?["Longt"] as? String ?? ""
            let noti = value?["Notf"] as? String ?? ""
            let driverName = value?["Name"] as? String ?? ""
            
//            AppDelegate.currentTrip.bestDriver = driver
//            AppDelegate.currentTrip.driverName = value?["Notf"] as? String ?? ""

            if (noti == "0"){

                let latD = Double (lat)!
                let longD = Double (long)!
                
                
                
                if (trip.distance == "-1"){
                    
                    trip.distance = self.calDistance(clat: latD, clon: longD, dlat: Double (trip.cLat)!, dlon: Double (trip.cLon)!)
                    trip.bestDriver = driver
                    trip.driverName = driverName
                    self.Blat = latD
                    self.Blong = longD
                }
                else {
                    let d = self.calDistance(clat: latD, clon: longD, dlat: Double (trip.cLat)!, dlon: Double (trip.cLon)!)
                    
                    if (Double (d)! < Double(trip.distance)!){
                        trip.distance  = d
                        trip.bestDriver = driver
                        trip.driverName = driverName
                        self.Blat = latD
                        self.Blong = longD
                    }
                }
            print(trip.distance)
            
               
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
//        let position = CLLocationCoordinate2DMake( AppDelegate.currentUser., longD)
//                        let marker = GMSMarker(position: position)
//                        marker.iconView = UIImageView(image : UIImage(named: img)!)
//
//                        marker.map = self.Map
        
        let position = CLLocationCoordinate2DMake( self.Blat, self.Blong)
        self.marker = GMSMarker(position: position)
        self.marker.iconView = UIImageView(image : UIImage(named: img)!)
        
        self.marker.map = self.Map

    }
    
   
    func calDistance(clat : Double,clon : Double,dlat : Double,dlon : Double)-> String{
        let coordinate0 = CLLocation(latitude: dlat, longitude: dlon)
        let coordinate1 = CLLocation(latitude:clat, longitude: clon)
        return  String (Int (coordinate0.distance(from: coordinate1)/1000))
        
    }
    
    
}

//extension RideTypeViewController: CLLocationManagerDelegate {
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.last {
//            self.userlocation = location
//            
//            
//            let cameraPosition = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 12)
//            Map.animate(to: cameraPosition)
//            
//            
//            AppDelegate.currentTrip.cLat = String (location.coordinate.latitude)
//            AppDelegate.currentTrip.cLon = String (location.coordinate.longitude)
//
//            let ceo: CLGeocoder = CLGeocoder()
//
//            ceo.reverseGeocodeLocation(location, completionHandler:
//                {(placemarks, error) in
//                    if (error != nil)
//                    {
//                        print("reverse geodcode fail: \(error!.localizedDescription)")
//                    }
//                    else {
//                    let pm = placemarks! as [CLPlacemark]
//
//                    if pm.count > 0 {
//                        let pm = placemarks![0]
//                        var addressString : String = ""
//                        if pm.subLocality != nil {
//                            addressString = addressString + pm.subLocality! + ", "
//                        }
//
//                        if pm.locality != nil {
//                            addressString = addressString + pm.locality! + ", "
//
//                        }
//
//                        AppDelegate.currentTrip.cTitle = addressString
//                        }
//                    }
//            })
//
//
//            
//            
//            CATransaction.commit()
//           
//            locationManager.stopUpdatingLocation()
//        }
//    }
//    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
//        if status == .authorizedWhenInUse {
//            // authorized location status when app is in use; update current location
//            locationManager.startUpdatingLocation()
//            Map.isMyLocationEnabled = true
//            Map.settings.myLocationButton = true
//            // implement additional logic if needed...
//        }
//        // implement logic for other status values if needed...
//    }
//}
//


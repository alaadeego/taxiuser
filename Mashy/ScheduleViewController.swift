//
//  ScheduleViewController.swift
//  Mashy
//
//  Created by Amal Khaled on 11/25/17.
//  Copyright © 2017 amany. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class ScheduleViewController: UIViewController ,GMSMapViewDelegate {

    @IBOutlet var datwTimePicker: UIDatePicker!
    
    @IBOutlet var Map: GMSMapView!
    @IBOutlet var dLocationLabel: UILabel!
    @IBOutlet var cLocationLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    //map
//    var userlocation:CLLocation = CLLocation()
//    var locationManager:CLLocationManager!
//

    override func viewDidLoad() {
        super.viewDidLoad()

        let trip = AppDelegate.currentTrip

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
        
        
        dLocationLabel.text = trip.dSubTilite
        cLocationLabel.text = "موقعك الحالي: " + trip.cTitle
        
        
        //draw line
         Services.services.drawPath(clat:trip.cLat, clon: trip.cLon, dlat: trip.dLat, dlon: trip.dLon , Map: Map)
        
        
        
        //distination marker
        let position = CLLocationCoordinate2DMake(Double (trip.dLat)!, Double (trip.dLon)!)
        let marker = GMSMarker(position: position)
        marker.map = self.Map
        
        
        
        //Date
        let timestamp = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .short)
        timeLabel.text = timestamp

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
 
    
    @IBAction func specificDateAction(_ sender: Any) {
        
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = DateFormatter.Style.short
        timeFormatter.dateStyle = DateFormatter.Style.medium

        let strDate = timeFormatter.string(from: datwTimePicker.date)
        AppDelegate.currentTrip.time = strDate
        performSegue(withIdentifier: "payment", sender: self)
    }
    
    @IBAction func currentDateAction(_ sender: Any) {
        AppDelegate.currentTrip.time = timeLabel.text!
        performSegue(withIdentifier: "payment", sender: self)

    }

    @IBAction func closeAction(_ sender: Any) {
    }
    
}
//
//extension ScheduleViewController: CLLocationManagerDelegate {
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
//
//
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


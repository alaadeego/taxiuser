//
//  ViewController.swift
//  Mashy
//
//  Created by mac on 10/26/17.
//  Copyright © 2017 amany. All rights reserved.
//

import UIKit
import Localize_Swift
import GoogleMaps
import GooglePlaces
import SkyFloatingLabelTextField

class ViewController: UIViewController, GMSMapViewDelegate  {
    
    
  
   
//    @IBOutlet var searchEditText: SkyFloatingLabelTextField!
    
    @IBOutlet var whereToGo: UILabel!
    
    @IBOutlet var Map: GMSMapView!
    @IBOutlet var menubtn: UIButton!
    @IBOutlet var titlelbl: UILabel!
    @IBOutlet var searchview: UIView!
    

    var userlocation:CLLocation = CLLocation()
    var locationManager:CLLocationManager!
    var newlocation:CLLocation!
    var placesClient: GMSPlacesClient!
    
//    @IBAction func test(_ sender: Any) {
//        print("test")
//
//        let searchController = UISearchController(searchResultsController:nil)
//        searchController.searchBar.delegate = self
//        self.present(searchController, animated: true, completion: nil)
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppDelegate.viewController = self
        
    //reset trip data
        AppDelegate.currentDriver = Driver()
        AppDelegate.currentTrip = Trip()
        AppDelegate.bestDrivers = [String]()
        

        titlelbl.text = "detectyourDestenation"//.localized()

        if revealViewController() != nil {
            revealViewController().rightViewRevealWidth = 270
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }


        menubtn.addTarget(revealViewController(), action:#selector(SWRevealViewController.rightRevealToggle(_:)), for: UIControlEvents.touchUpInside)

        let camera = GMSCameraPosition.camera(withLatitude: 1.285, longitude: 103.848, zoom: 12)


        let map = GMSMapView.map(withFrame: .zero, camera: camera)
        map.delegate = self

        self.Map.delegate = self
        self.Map.isMyLocationEnabled = true
        self.Map.settings.myLocationButton = true
        self.Map.isIndoorEnabled = true
        
//        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = Map

        locationManager=CLLocationManager()
       
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.delegate = self
        userlocation = CLLocation()
        newlocation = CLLocation()
        
        placesClient = GMSPlacesClient.shared()



//        searchview.layer.cornerRadius = 10
//        searchview.layer.shadowColor = UIColor.gray.cgColor
//        searchview.layer.shadowOffset = CGSize.zero
//        searchview.layer.shadowOpacity = 1
//        searchview.layer.shadowRadius = 5
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(whereToGoTapped))
        whereToGo.isUserInteractionEnabled = true
        whereToGo.addGestureRecognizer(tapGestureRecognizer)


               // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func whereToGoTapped(){

        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }

  
    override func viewWillAppear(_ animated: Bool) {
        //Change status bar color
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = UIColor(rgb:0xf57c00)
    }


    func open_side_menu(){

        revealViewController().rightRevealToggle(animated: true)


    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


//  func mapView(_ mapView: GMSMapView!, didChange position: GMSCameraPosition!) {
//        print("didChangeCameraPosition = \(position.target.latitude) \(position.target.longitude)")
//
//    }
//
//    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
//        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
//        //  mapView.clear()
//
//        let myLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        print(myLocation)
//
//    }
//    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//        print("You tapped at marker \(marker.position.latitude), \(marker.position.longitude)")
//        return true
//    }
//    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
//        // mapView.clear()
//        print("map will move")
//
//
//    }
//
//    override func didMove(toParentViewController parent: UIViewController?) {
//        print("map did move")
//    }
//
//
//    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
//        print("end dragging")
//    }
//    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
//        print("begin dragging")
//    }
//    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
//        print("map stopped = \(position.target.latitude) \(position.target.longitude)")
//
//        //        lat = position.target.latitude
//        //        lng = position.target.longitude
//
//
//
//
//
//    }


}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
extension ViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.userlocation = location
            
            
            let cameraPosition = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 12)
            Map.animate(to: cameraPosition)
            
            
            AppDelegate.currentTrip.cLat = String (location.coordinate.latitude)
            AppDelegate.currentTrip.cLon = String (location.coordinate.longitude)
//            AppDelegate.currentUser.dTitle = location.
          
            
            let ceo: CLGeocoder = CLGeocoder()
            ceo.reverseGeocodeLocation(location, completionHandler:
                {(placemarks, error) in
                    if (error != nil)
                    {
                        print("reverse geodcode fail: \(error!.localizedDescription)")
                    }
                    else {
                    let pm = placemarks! as [CLPlacemark]
                    
                    if pm.count > 0 {
                        let pm = placemarks![0]
                        var addressString : String = ""
                        if pm.subLocality != nil {
                            addressString = addressString + pm.subLocality! + ", "
                        }
                        
                        if pm.locality != nil {
                            addressString = addressString + pm.locality! + ", "

                        }
                        AppDelegate.currentTrip.cTitle = addressString

                        }


                        
                    }
            })



            CATransaction.commit()
            // Amany Edit --- > add marker of location detected up with latiude and longitude
//            let marker = GMSMarker()
//            marker.position = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
////            marker.appearAnimation = KGMSMarkerani//kGMSMarkerAnimationPop
            
            


            locationManager.stopUpdatingLocation()
        }
    }
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            // authorized location status when app is in use; update current location
//            locationManager.startUpdatingLocation()
            Map.isMyLocationEnabled = true
            Map.settings.myLocationButton = true
            // implement additional logic if needed...
        }
        // implement logic for other status values if needed...
    }

   
    


}

extension ViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
      
        AppDelegate.currentTrip.dLat = String (place.coordinate.latitude)
        AppDelegate.currentTrip.dLon = String (place.coordinate.longitude)
        AppDelegate.currentTrip.dTitle = place.name
        AppDelegate.currentTrip.dSubTilite = place.formattedAddress!

        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "choose_car", sender: AppDelegate.viewController)

    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}



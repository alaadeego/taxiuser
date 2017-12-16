//
//  ConfirmViewController.swift
//  Mashy
//
//  Created by Amal Khaled on 11/26/17.
//  Copyright © 2017 amany. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps



class ConfirmViewController: UIViewController ,GMSMapViewDelegate{

   
    @IBOutlet var Map: GMSMapView!
   
    @IBOutlet var myLocation: UILabel!
    @IBOutlet var myDistination: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var dTitle: UILabel!
    @IBOutlet var space: UILabel!
    @IBOutlet var cLocation: UILabel!
    
    @IBOutlet var dsubTitleLabel: UILabel!
    
    //fireBase
    var ref: FIRDatabaseReference?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //firebase
        self.ref = FIRDatabase.database().reference()
        
        let trip = AppDelegate.currentTrip
        
        let camera = GMSCameraPosition.camera(withLatitude: Double (trip.cLat)!, longitude:  Double (trip.cLon)!, zoom: 12)
        Map.animate(to: camera)
        
        
        let map = GMSMapView.map(withFrame: .zero, camera: camera)
        map.delegate = self
        
        self.Map.delegate = self
        self.Map.isMyLocationEnabled = true
        self.Map.settings.myLocationButton = true
        self.Map.isIndoorEnabled = true
        
        
        myDistination.text = trip.dSubTilite
        myLocation.text = "موقعك الحالي: " + trip.cTitle
        
        price.text = trip.tripPrice
        
        //draw line
        Services.services.drawPath(clat:trip.cLat, clon: trip.cLon, dlat: trip.dLat, dlon: trip.dLon , Map: Map)
        
        
        
        
        //distination marker
        let position = CLLocationCoordinate2DMake(Double (trip.dLat)!, Double (trip.dLon)!)
        let marker = GMSMarker(position: position)
        marker.map = self.Map
        
        myLocation.text = trip.cTitle
        dTitle.text = trip.dTitle
        dsubTitleLabel.text = trip.dSubTilite

        space.text = "المسافه " + trip.tripDistance + " كم "
        
        
        
        

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

    @IBAction func closeAction(_ sender: Any) {
    }
   
    @IBAction func nextButtonClicked(_ sender: Any) {
        
        let trip  = AppDelegate.currentTrip
        print("/////////////////")
        print(trip.carType)
        if (trip.bestDriver != ""){
            let post = ["Notf": AppDelegate.currentUser.ID + "User" , "UserAddress": trip.cTitle ,"UserLat": trip.dLat ,"UserLongt": trip.dLon]
        
            self.ref?.child(trip.carType).child(trip.bestDriver).updateChildValues(post )
            
            performSegue(withIdentifier: "done", sender: self)
        }

    }
}

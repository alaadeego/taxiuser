//
//  PaymentViewController.swift
//  Mashy
//
//  Created by Amal Khaled on 11/26/17.
//  Copyright © 2017 amany. All rights reserved.
//

import UIKit
import GoogleMaps


class PaymentViewController: UIViewController ,GMSMapViewDelegate{

    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var Map: GMSMapView!
    @IBOutlet var dLocationLabel: UILabel!
    @IBOutlet var cLocationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let trip = AppDelegate.currentTrip

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
   

    @IBAction func payPaypallAction(_ sender: Any) {
        
        
    }
    @IBAction func payCashAction(_ sender: Any) {
    }
    @IBAction func cancelAction(_ sender: Any) {
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        Services.services.getPrices(uiViewController: self)
    }
}

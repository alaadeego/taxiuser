//
//  Trip.swift
//  Mashy
//
//  Created by Amal Khaled on 11/25/17.
//  Copyright © 2017 amany. All rights reserved.
//

import Foundation

class Trip {
    var cLon : String = ""
    var cLat : String = ""
    var cTitle : String = ""
    var dLon : String = ""
    var dLat : String = ""
    var dTitle : String = ""
    var dSubTilite : String = ""
    var time : String = ""
    var bestDriver : String = ""
    var driverName : String = ""
    var distance : String = "-1"
    var tripDistance : String = ""
    var driverFar : String = ""
    var carType : String = "Economic"
    var carImage : String = "carblue" 

    var tripPrice : String = ""

    
    init (end:String , price : String , start: String , time:String , distance:String  ){
        self.cTitle = start
        self.dTitle = end
        self.tripPrice = price
        self.time = time
        self.tripDistance = distance
    }
    init(){
    }
    
    
}

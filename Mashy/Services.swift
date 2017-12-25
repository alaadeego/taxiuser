//
//  Services.swift
//  Mashy
//
//  Created by Amal Khaled on 11/4/17.
//  Copyright © 2017 amany. All rights reserved.
//

import Foundation
import Alamofire
import Firebase
import SwiftyJSON
import GoogleMaps



class Services{
    static  let services = Services()
    
    //fireBase
    var ref: FIRDatabaseReference?

    //--------------------------------------------------------------------------------------------\\

    //#MARK: -
    //#MARK: - Newely added methods by Mukesh
    //#MARK: -
    
    //--------------------------------------------------------------------------------------------\\

    
    //#MARK: - Send Code API
    func sendCode(uiViewController : UIViewController , code:String ,numbers:String, loginType:Int){
        let parameters: Parameters = ["mobile": "966563403905" ,
                                      "password": "123asd!@#" ,
                                      "sender": "AAIT.SA" ,
                                      "msg": code ,
                                      "lang": "3" ,
                                      "applicationType": "68" ,
                                      "numbers": numbers]
        let link = Constants.SEND_CODE
        Alamofire.request(link, method: .post, parameters: parameters).responseJSON { response in
            print(response.result.value!)
            let JSON = response.result.value  as? NSDecimalNumber
            let number = JSON
            if number != nil {
                if number == 1 {
                    if loginType == 1{
                        //General Login Type
                        uiViewController.performSegue(withIdentifier: "enter_code", sender: self)
                    }else{
                        //Social Login Type
                        let mainStoryboard:UIStoryboard = UIStoryboard(name:"Main" , bundle:nil)
                        let desController = mainStoryboard.instantiateViewController(withIdentifier: "CodeRegisterViewController") as! CodeRegisterViewController
                        uiViewController.present(desController, animated: true, completion: nil)
                    }
                }else{
                    uiViewController.view.makeToast("الرقم غير صالح".localized())
                }
                
            }else{
                uiViewController.view.makeToast("لا يوجد انترنت".localized())
            }
        }
    }
    
    //#MARK: - Check Email for Reset

    func checkEmailForReset(uiViewController : UIViewController, completion_callback: @escaping (_ result: String) -> Void){
        let link = Constants.CHECK_EMAIL + "?Email=" + AppDelegate.currentUser.email
        print (link)
        Alamofire.request(link, method: .get ).responseJSON { response in
            if let JSON = response.result.value  as? NSDictionary{
                let check = JSON["result"] as! String
                if (check == "found"){
                    completion_callback("success")
                }
                else {
                    uiViewController.view.makeToast("هذا الايميل غير موجود مسبقا")
                    completion_callback("failed")
                }
            }
            else{
                uiViewController.view.makeToast("لا يوجد انترنت".localized())
                completion_callback("failed")
            }
        }
    }
    
    //#MARK: - Check Phone for Reset Pwd

    func checkPhone(uiViewController : UIViewController, completion_callback: @escaping (_ result: String) -> Void){
        
        
        let link = Constants.CHECK_PHONE + "?Email=" + AppDelegate.currentUser.email
        Alamofire.request(link, method: .get ).responseJSON { response in
            if let JSON = response.result.value  as? NSDictionary{
                let check = JSON["result"] as! String
              
                if (check == "not found"){
                    uiViewController.view.makeToast("هذا الايميل غير موجود مسبقا")
                    completion_callback("failed")
                }else {
                    completion_callback(check)
                }
            }
            else{
                uiViewController.view.makeToast("لا يوجد انترنت".localized())
                completion_callback("failed")
                
            }
        }
    }
    
    //#MARK: - Reset Pwd API Call
    func resetPassward(uiViewController : UIViewController){
        let parameters: Parameters = ["Password": AppDelegate.currentUser.pass ,
                                      "Email": AppDelegate.currentUser.email ]
        
        let link = Constants.RESET_PASS
        Alamofire.request(link, method: .get, parameters: parameters).responseJSON { response in
            print(response.result.value as Any)
            if let JSON = response.result.value  as? NSDictionary{
                let check = JSON["Result"] as! String
                if (check == "Done"){
                }
            }
            else{
                uiViewController.view.makeToast("لا يوجد انترنت".localized())
            }
            
        }
    }
    
    
    //#MARK: - Check Email Exist or Not

    func checkEmailExistOrNot(uiViewController : UIViewController, email: String){
        let defaults:UserDefaults = UserDefaults.standard
        
        let link = Constants.CHECK_EMAIL + "?Email=" + email
        print (link)
        Alamofire.request(link, method: .get ).responseJSON { response in
            print(response.result.value as Any)
            if let JSON = response.result.value  as? NSDictionary{
                let check = JSON["result"] as! String
                if (check == "found"){
                    
                    defaults.set( email, forKey: "Email_KeyPref")
                    defaults.set("", forKey: "ID_KeyPref")
                    defaults.set("1", forKey: "IS_LOGIN")
                    
                    uiViewController.performSegue(withIdentifier: "map", sender: uiViewController)
                }
                else {
                    //Phone scene to insert social user
                    
                    let mainStoryboard:UIStoryboard = UIStoryboard(name:"Main" , bundle:nil)
                    let desController = mainStoryboard.instantiateViewController(withIdentifier: "PhoneViewController") as! PhoneViewController
                    uiViewController.present(desController, animated: true, completion: nil)

                }
            }
            else{
                uiViewController.view.makeToast("لا يوجد انترنت".localized())
            }
        }
    }
    
    //#MARK: - Insert User API Call
    func insertUser(uiViewController : UIViewController){
       
        let  userPhone = "+"+AppDelegate.currentUser.phone // Appending + sign to save phone in original format
        
        let parameters: Parameters = ["Password": AppDelegate.currentUser.pass ,
                                      "Email": AppDelegate.currentUser.email ,
                                      "Name": AppDelegate.currentUser.name ,
                                      "Phone": userPhone ]
        
        let link = Constants.SIGN_UP
        Alamofire.request(link, method: .get, parameters: parameters).responseJSON { response in
            print(response.result.value as Any)
            if let JSON = response.result.value  as? NSDictionary{
                let check = JSON["Result"] as! String
                if (check == "successfully"){
                            let mainStoryboard:UIStoryboard = UIStoryboard(name:"Main" , bundle:nil)
                    let desController:FinshSignUpViewController = mainStoryboard.instantiateViewController(withIdentifier: "signupfinished") as! FinshSignUpViewController
                    desController.isFromSocialLogin = true
                    uiViewController.present(desController, animated: true, completion: nil)
                }
            }
            else{
                uiViewController.view.makeToast("لا يوجد انترنت".localized())
            }
            
        }
    }
    
    
    //  Call To GetUserTrips for user
    func callToGetUserTrips(uiViewController : UIViewController,
                            completion_callback: @escaping (_ result: NSDictionary) -> Void){
        
        let link = Constants.USER_TRIPS + "?Email=" + AppDelegate.currentUser.email
        
        Alamofire.request(link, method: .get ).responseJSON { response in
            if let JSON = response.result.value  as? NSDictionary{
                completion_callback(JSON)
            }
            else{
                uiViewController.view.makeToast("لا يوجد انترنت".localized())
            }
            
        }
    }
    
    
    //--------------------------------------------------------------------------------------------\\
    
    //#MARK: -
    //#MARK: - Newely added methods by Mukesh end
    //#MARK: -
    
    
    //--------------------------------------------------------------------------------------------\\

    
    
    func checkEmail(uiViewController : UIViewController){
        
        
        let link = Constants.CHECK_EMAIL + "?Email=" + AppDelegate.currentUser.email
        print (link)
        Alamofire.request(link, method: .get ).responseJSON { response in
            print(response.result.value)

            if let JSON = response.result.value  as? NSDictionary{
                let check = JSON["result"] as! String
                
                if (check == "not found"){
                    let mainStoryboard:UIStoryboard = UIStoryboard(name:"Main" , bundle:nil)
                    let desController = mainStoryboard.instantiateViewController(withIdentifier: "cusu") as! CompleteUserSignUpViewController
                    let newFrontViewController = UINavigationController.init(rootViewController: desController)
                    uiViewController.present(newFrontViewController, animated: true, completion: nil)
                }
                else {
                    uiViewController.view.makeToast("هذا الايميل موجود مسبقا")

                }
//                uiViewController.view.makeToast(NSLocalizedString("تم", comment: ""))


            }
            else{
                uiViewController.view.makeToast("لا يوجد انترنت".localized())

//                self.CreateDialog(uiViewController: uiViewController)



            }

        }
    }
   
    
    func SIGNUP(uiViewController : UIViewController){
        let link = Constants.SIGN_UP + "?Email=" + AppDelegate.currentUser.email + "&Name=" +
            "" + "&Password=" + AppDelegate.currentUser.pass + "&Phone=" + ""
        print (link)
        Alamofire.request(link, method: .get ).responseJSON { response in
            print(response.result.value as Any)
            
            if let JSON = response.result.value  as? NSDictionary{
                let check = JSON["Result"] as! String
                
                if (check == "successfully"){
                    
                   
                    //New Code by Mukesh
                    
                    let mainStoryboard:UIStoryboard = UIStoryboard(name:"Main" , bundle:nil)
                    let desController = mainStoryboard.instantiateViewController(withIdentifier: "PhoneViewController") as! PhoneViewController
                    uiViewController.present(desController, animated: true, completion: nil)

                    
                    
                    /*
                     
                     let mainStoryboard:UIStoryboard = UIStoryboard(name:"Main" , bundle:nil)
                     let desController = mainStoryboard.instantiateViewController(withIdentifier: "signupfinished") as! FinshSignUpViewController
                     let newFrontViewController = UINavigationController.init(rootViewController: desController)
                     uiViewController.present(newFrontViewController, animated: true, completion: nil)
                     
                     */
                    
                }
                else {
                    uiViewController.view.makeToast("هذا الايميل موجود مسبقا".localized())
                    let mainStoryboard:UIStoryboard = UIStoryboard(name:"Main" , bundle:nil)
                    let desController = mainStoryboard.instantiateViewController(withIdentifier: "user_email") as! UserEmailViewController
                    let newFrontViewController = UINavigationController.init(rootViewController: desController)
                    uiViewController.present(newFrontViewController, animated: true, completion: nil)
                    
                }
                
                
            }
            else{
                uiViewController.view.makeToast("لا يوجد انترنت".localized())
                
            }
            
        }
    }
    
    func login(uiViewController : UIViewController){
        let defaults:UserDefaults = UserDefaults.standard
        
        let link = Constants.LOGIN_IN + "?Email=" + AppDelegate.currentUser.email +  "&Pass=" + AppDelegate.currentUser.pass
        print (link)
        Alamofire.request(link, method: .get ).responseJSON { response in
            print(response.result.value)
            
            if let JSON = response.result.value  as? NSDictionary{
                if let check = JSON["result"] as? String {


                      uiViewController.view.makeToast("البريد الالكتروني او كلمه المرور غير صحيحه".localized())

                }
                else if let check = JSON["result"] as? NSArray {
//                    print(check[0]["Name"])
                    let user = check[0] as? NSDictionary

                    AppDelegate.currentUser.name = user!["Name"] as! String
                    AppDelegate.currentUser.phone = user!["Phone"] as! String
                    AppDelegate.currentUser.ID = user!["ID"] as! String

                    //firebase
                    self.ref = FIRDatabase.database().reference()
                    self.ref?.child("Users").child(AppDelegate.currentUser.ID + "User").setValue(["Email": AppDelegate.currentUser.email , "ID": AppDelegate.currentUser.ID ,"Name": AppDelegate.currentUser.name ,"Phone": AppDelegate.currentUser.phone , "Request": "0"]  )
                    
                    defaults.set( AppDelegate.currentUser.email, forKey: "email")
                    defaults.set(AppDelegate.currentUser.pass, forKey: "pass")

                    //go to sceond map view
                   uiViewController.performSegue(withIdentifier: "map", sender: uiViewController)
                    //swreveal
                }
                

                
                
            }
            else{
                uiViewController.view.makeToast(("لا يوجد انترنت").localized())
                
            }
            
        }
    }
    
//    func checkDriverPhone(uiViewController : PhoneNumberViewController){
//        let link = Constants.CHECK_DRIVER_PHONE + "?Phone=" + AppDelegate.currentDriver.phoneNumber
//        print(link)
//        Alamofire.request(link, method: .get ).responseJSON { response in
//
//            print(response.result.value)
//
//            if let JSON = response.result.value  as? NSDictionary{
//                let check = JSON["result"] as! String
//
//                if (check == "not found"){
//
//                    uiViewController.performSegue(withIdentifier: "driverEmail", sender: uiViewController)
//                }
//                else {
//                    //                    uiViewController.view.makeToast("هذا الايميل موجود مسبقا".localized())
//                    uiViewController.errorLable.isHidden = false
//
//                }
//
//
//            }
//            else{
//                uiViewController.view.makeToast("لا يوجد انترنت".localized())
//
//            }
//
//        }
//    }
    func resetPass(uiViewController : UIViewController){
        let parameters: Parameters = ["Password": AppDelegate.currentDriver.pass ,
                                      "Email": AppDelegate.currentDriver.email ]
        
        
        
        
        let link = Constants.RESET_PASS
        
        Alamofire.request(link, method: .get, parameters: parameters).responseJSON { response in
            print(response.result.value)
            
                        if let JSON = response.result.value  as? NSDictionary{
                            let check = JSON["Result"] as! String
            
                            if (check == "Done"){
            
                                uiViewController.performSegue(withIdentifier: "map", sender: uiViewController)
                            }
                           
            
                        }
                        else{
                            uiViewController.view.makeToast("لا يوجد انترنت".localized())
            
                        }
            
        }
      
        
    }
    func checkDriverEmail(uiViewController : DriverEmailViewController){
        let link = Constants.CHECK_DRIVER_EMAIL + "?Email=" + AppDelegate.currentDriver.email
        Alamofire.request(link, method: .get ).responseJSON { response in
            print(response.result.value)
            
            if let JSON = response.result.value  as? NSDictionary{
                let check = JSON["result"] as! String
                
                if (check == "not found"){
                   uiViewController.performSegue(withIdentifier: "driver_pass", sender: uiViewController)
                }
                else {
                    uiViewController.errorLabel.isHidden = false

                }
             
                
            }
            else{
                uiViewController.view.makeToast("لا يوجد انترنت".localized())
                
            }
            
        }
    }
    func checkDriverPhone(uiViewController : PhoneNumberViewController){
        let link = Constants.CHECK_DRIVER_PHONE + "?Phone=" + AppDelegate.currentDriver.phoneNumber
        print(link)
        Alamofire.request(link, method: .get ).responseJSON { response in
            
            print(response.result.value)
            
            if let JSON = response.result.value  as? NSDictionary{
                let check = JSON["result"] as! String
                
                if (check == "not found"){

                    uiViewController.performSegue(withIdentifier: "driverEmail", sender: uiViewController)
                }
                else {
//                    uiViewController.view.makeToast("هذا الايميل موجود مسبقا".localized())
                    uiViewController.errorLable.isHidden = false
                    
                }
                
                
            }
            else{
                uiViewController.view.makeToast("لا يوجد انترنت".localized())
                
            }
            
        }
    }
    func DriverLogin(uiViewController : UIViewController){
        let start = NSDate()
        let parameters: Parameters = ["ID": AppDelegate.currentDriver.ID ,
                                      "Email": AppDelegate.currentDriver.email ,
                                      "Address": AppDelegate.currentDriver.lincese ,
                                      "LicencePhoto": AppDelegate.currentDriver.name ,
                                      "NationalIDPhoto": AppDelegate.currentDriver.IDImage ,
                                      "password": AppDelegate.currentDriver.pass ,
                                      "PersonalPhoto": AppDelegate.currentDriver.profilePic ,
                                      "Phone": AppDelegate.currentDriver.phoneNumber ]

        
        
        
        let link = Constants.DRIVER_LOGIN

      Alamofire.request(link, method: .post, parameters: parameters).responseJSON { response in
            print(response.result.value)
        
//            if let JSON = response.result.value  as? NSDictionary{
//                let check = JSON["result"] as! String
//                
//                if (check == "not found"){
//                    
//                    uiViewController.performSegue(withIdentifier: "driverEmail", sender: uiViewController)
//                }
//                else {
//                    //                    uiViewController.view.makeToast("هذا الايميل موجود مسبقا".localized())
//                    uiViewController.errorLable.isHidden = false
//                    
//                }
                
                
//            }
//            else{
//                uiViewController.view.makeToast("لا يوجد انترنت".localized())
//
//            }
            
        }
        let end = NSDate()
        let timeInterval: Double = end.timeIntervalSince(start as Date) // <<<<< Difference in seconds (double)
        
        print(timeInterval)
        
    }
    
    func testUpload (uiViewController : UIViewController){
        let start = NSDate()
        let images = AppDelegate.uploadedImages
        let link = Constants.DRIVER_LOGIN
        let parameters = ["ID": AppDelegate.currentDriver.ID ,
                                      "Email": AppDelegate.currentDriver.email ,
                                      "Address": AppDelegate.currentDriver.lincese ,
                                      "password": AppDelegate.currentDriver.pass ,
                                      "Phone": AppDelegate.currentDriver.phoneNumber ]

        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                for image in images {
                    if let imageData = UIImageJPEGRepresentation(image, 0.5) {
                        multipartFormData.append(imageData, withName: "image", fileName: "file.jpeg", mimeType: "image/jpeg")
                    }
                }
                for (key, value) in parameters {
                        multipartFormData.append(value.data(using: String.Encoding.utf8)! , withName: key)
                }
                
        },
            to: link,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        print(response.result.value)
                        
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
        }
        )
        let end = NSDate()
        let timeInterval: Double = end.timeIntervalSince(start as Date) // <<<<< Difference in seconds (double)
        
        print(timeInterval)
    }
    
  
    func drawPath(clat : String,clon : String,dlat : String,dlon : String  , Map : GMSMapView)
    {
        let origin = "\(clat),\(clon)"
        let destination = "\(dlat),\(dlon)"
        
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=AIzaSyAAzXo5BHq_tVgIIOdO1b2juR2Ie4VAPN0"
        
        Alamofire.request(url).responseJSON { response in
//            print(response.data)     // server data
            do {
            let json = try JSON(data: response.data!)

            let routes = json["routes"].arrayValue
                let dArray = routes[0]["legs"].arrayValue
                let distance = dArray[0]["distance"].dictionary
                let duration = dArray[0]["duration"].dictionary
                let spcae = Double( distance!["value"]?.stringValue as! String)!
               
                AppDelegate.currentTrip.tripDistance = String ( round(spcae/1000))
                
                AppDelegate.currentTrip.driverFar = duration!["text"]?.stringValue as! String

                
            for route in routes
            {
//                let d = route["legs"].arrayValue
                    //![0]["distance"] as! String
                let routeOverviewPolyline = route["overview_polyline"].dictionary
                let points = routeOverviewPolyline?["points"]?.stringValue
                let path = GMSPath.init(fromEncodedPath: points!)
                let polyline = GMSPolyline.init(path: path)
                polyline.map = Map
            }
            }catch{
                print(error)

            }
        }
    }
    
    func getDriverData(uiViewController : UIViewController){
        let link = Constants.DRIVER_INFO + "?Email=" + AppDelegate.currentDriver.email
        print (link)
        Alamofire.request(link, method: .get ).responseJSON { response in
            print(response.result.value)
            
            if let JSON = response.result.value  as? NSDictionary{
                
                if let check = JSON["result"] as? String {
                    
                    
                    uiViewController.view.makeToast("البريد الالكتروني او كلمه المرور غير صحيحه".localized())
                    
                }
                else if let check = JSON["result"] as? NSArray {
                    //                    print(check[0]["Name"])
                    let user = check[0] as? NSDictionary
                    
                    AppDelegate.currentDriver.name = user!["Name"] as! String
                    AppDelegate.currentDriver.phoneNumber = user!["Phone"] as! String
                    AppDelegate.currentDriver.ID = user!["NationalID"] as! String
                    AppDelegate.currentDriver.rating = user!["Rate"] as! String
                    AppDelegate.currentDriver.address = user!["Address"] as! String
                    AppDelegate.currentDriver.profilePic = user!["PersonalPhoto"] as! String

                    print(AppDelegate.currentDriver.name)
                    //go to sceond map view
                    uiViewController.performSegue(withIdentifier: "driver", sender: uiViewController)
                    //swreveal
                }
                
                
                
            }
            else{
                uiViewController.view.makeToast("لا يوجد انترنت".localized())
                
            }
            
        }
    }
    
    //get all trips for user
    func getUserTrips(uiViewController : UIViewController){
        let link = Constants.USER_TRIPS + "?Email=" + AppDelegate.currentUser.email
        var trips :Array = [Trip]()
        
        Alamofire.request(link, method: .get ).responseJSON { response in
//            print(response.result.value)
            
            if let JSON = response.result.value  as? NSDictionary{
                
                if let check = JSON["result"] as? String {
                      uiViewController.view.makeToast("البريد الالكتروني صحيح".localized())
                }
                else if let check = JSON["result"] as? NSArray {
                    //                    print(check[0]["Name"])
                    
                    print(check)
                    
                     for i in 0 ..< check.count {
                        let userTrip = check[0] as? NSDictionary
                    
                        trips.append(Trip(end: userTrip!["End"] as! String,price: userTrip!["Price"] as! String,start: userTrip!["Start"] as! String,time: userTrip!["Time"] as! String,distance: userTrip!["Distance"] as! String))
                    }
//                    uiViewController.trips = trips
                    
                    
                  
//                    uiViewController.performSegue(withIdentifier: "driver", sender: uiViewController)
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "trips") as! TripsViewController
                    vc.trips = trips
                    let newFrontViewController = UINavigationController.init(rootViewController: vc)
                    uiViewController.present(newFrontViewController, animated: true, completion: nil)
                }
                
                
                
            }
            else{
                uiViewController.view.makeToast("لا يوجد انترنت".localized())
                
            }
            
        }
    }
    func ratingDriver(uiViewController : UIViewController , rate:String){

        let link = Constants.RATING + "?Driver=" + AppDelegate.currentDriver.email +  "&Owner=" + AppDelegate.currentUser.email + "&Rate=" + rate
        print (link)
        Alamofire.request(link, method: .get ).responseJSON { response in
            print(response.result.value)
            
            if let JSON = response.result.value  as? NSDictionary{
                uiViewController.performSegue(withIdentifier: "finish", sender: uiViewController)
            }
            else{
                uiViewController.view.makeToast(("لا يوجد انترنت").localized())
                
            }
            
        }
    }
    func getPrices(uiViewController : UIViewController){
        let defaults:UserDefaults = UserDefaults.standard
        
        let link = Constants.GET_PRICES
        print (link)
        Alamofire.request(link, method: .get ).responseJSON { response in
            print(response.result.value)
            
            if let JSON = response.result.value  as? NSDictionary{
            if let check = JSON["result"] as? NSArray {
                let prices = check[0] as? NSDictionary

                if (AppDelegate.currentTrip.carType == "Economic"){
                    let carPrice =  Int (prices!["Economic"] as! String)! * Int (AppDelegate.currentTrip.distance)!
                    AppDelegate.currentTrip.tripPrice = String ( carPrice)
                }
                else if (AppDelegate.currentTrip.carType == "Rioyal"){
                    //Private
                    let carPrice = Int(prices!["Mine"] as! String)! * Int (AppDelegate.currentTrip.distance)!
                    AppDelegate.currentTrip.tripPrice = String ( carPrice)

                }
                else if (AppDelegate.currentTrip.carType == "Special"){
                    //Mine
                    let carPrice = Int (prices!["Private"] as! String)! * Int (AppDelegate.currentTrip.distance)!
                    AppDelegate.currentTrip.tripPrice =  String ( carPrice)

                }
              uiViewController.performSegue(withIdentifier: "confirm", sender: uiViewController)

                
                }
                
                
                
                
            }
            else{
                uiViewController.view.makeToast(("لا يوجد انترنت").localized())
                
            }
            
        }
    }
    
    func cancelTripReasons(uiViewController : UIViewController){
        let link = Constants.GET_CANCEL_REASONS
        var reasons :Array = [CancelTripReasons]()
        
        Alamofire.request(link, method: .get ).responseJSON { response in
            //            print(response.result.value)
            
            if let JSON = response.result.value  as? NSDictionary{
                
              if let check = JSON["result"] as? NSArray {
                    //                    print(check[0]["Name"])
                    
                    print(check)
                    
                    for i in 0 ..< check.count {
                        let reason = check[0] as? NSDictionary
                        let id = reason!["ID"] as! String
                        if (AppDelegate.lang == "ar"){
                            reasons.append(CancelTripReasons(id: id, title: reason!["ArabicResones"] as! String))
                        }
                        else{
                            reasons.append(CancelTripReasons(id: id, title: reason!["EnglishResons"] as! String))

                        }
                        
                        
                    }
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "cancel_trip") as! CancelTripViewController
                print(reasons.count)
                vc.resonsArray = reasons
                let newFrontViewController = UINavigationController.init(rootViewController: vc)
                uiViewController.present(newFrontViewController, animated: true, completion: nil)

                }
                
                
                
            }
            else{
                uiViewController.view.makeToast("لا يوجد انترنت".localized())
                
            }
            
        }
    }
    
    func cancelTrip(uiViewController : UIViewController , reasonId:String , note:String){
    
        var link = Constants.CANCEL_TRIP + "?Note=" + note + "&Email=" + AppDelegate.currentUser.email + "&ReasonId=" + reasonId
        link = link.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!

        
        Alamofire.request(link, method: .get ).responseJSON { response in
                        print(response.result.value)
            
            if let JSON = response.result.value  as? NSDictionary{
                
                    
                    uiViewController.performSegue(withIdentifier: "finish", sender: uiViewController)
               

               
            }
            else{
                uiViewController.view.makeToast("لا يوجد انترنت".localized())
                
            }
            
        }
    }
}

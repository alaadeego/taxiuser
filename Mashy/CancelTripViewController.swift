//
//  CancelTripViewController.swift
//  Mashy
//
//  Created by Amal Khaled on 12/9/17.
//  Copyright © 2017 amany. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class CancelTripViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource{
   

    @IBOutlet var cancelTrip: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet var note: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet var reasons: UITableView!
    
    var selectedId = "0"
    var resonsArray : Array = [CancelTripReasons]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelTrip.isLTRLanguage = false
        note.isLTRLanguage = false
        
           cancelTrip.addTarget(self, action: #selector(CancelTripViewController.cancelTripTaped), for: .touchDown)

        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UserLoginViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    func cancelTripTaped(){
        
        if (reasons.isHidden){
            reasons.isHidden = false
        }
        else {
            reasons.isHidden = true
            
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resonsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell!.textLabel?.text = self.resonsArray[indexPath.row].title
        return cell!
        
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if (textField == cancelTrip){

            return false;
        }
        else{

            return true
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        reasons.isHidden = true
        cancelTrip.text = resonsArray[indexPath.row].title
        selectedId =  resonsArray[indexPath.row].id
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func cancelTrip(_ sender: Any) {
//        performSegue(withIdentifier: "finish", sender: self)
        
        if (cancelTrip.text?.count != 0){
            Services.services.cancelTrip(uiViewController: self, reasonId: selectedId, note: note.text!)
        }
        
    }
    
}

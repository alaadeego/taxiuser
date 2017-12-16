//
//  TripsViewController.swift
//  Mashy
//
//  Created by Amal Khaled on 12/3/17.
//  Copyright © 2017 amany. All rights reserved.
//

import UIKit

class TripsViewController: UIViewController  , UITableViewDelegate, UITableViewDataSource {

    var trips: Array = [Trip]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(trips.count)
        
//        Services.services.getUserTrips(uiViewController: self)
        

        // Do any additional setup after loading the view.
        //back button
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! tripsTableViewCell
        cell.cLocationLabel.text = trips[indexPath.row].cTitle
        cell.dLocationTitle.text = trips[indexPath.row].dTitle
        cell.dLocationSubTiltle.text = trips[indexPath.row].dTitle
        cell.costLabel.text = trips[indexPath.row].tripPrice
        cell.spaceLabel.text = trips[indexPath.row].tripDistance
        cell.time.text = trips[indexPath.row].time

        cell.backGroundView.layer.cornerRadius = 5.0
        cell.backGroundView.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        cell.backGroundView.layer.borderWidth = 0.5
        
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        border.frame = CGRect(x: 0, y: cell.backGroundView.frame.size.height - width, width:  cell.backGroundView.frame.size.width, height: cell.backGroundView.frame.size.height)

        border.borderWidth = width
        cell.backGroundView.layer.addSublayer(border)
        cell.backGroundView.layer.masksToBounds = true
        cell.backGroundView.clipsToBounds = true
       
        
        return cell
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

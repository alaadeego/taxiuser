//
//  tripsTableViewCell.swift
//  Mashy
//
//  Created by Amal Khaled on 12/3/17.
//  Copyright © 2017 amany. All rights reserved.
//

import UIKit

class tripsTableViewCell: UITableViewCell {
    
    @IBOutlet var spaceLabel: UILabel!
    @IBOutlet var backGroundView: UIView!
    @IBOutlet var costLabel: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var dLocationSubTiltle: UILabel!
    @IBOutlet var dLocationTitle: UILabel!
    @IBOutlet var cLocationLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        backgroundColor = c.colorClear
        
//        self.backGroundView.layer.borderWidth = 1
//        self.backGroundView.layer.cornerRadius = 3
//        self.backGroundView.layer.borderColor = Colors.colorClear.cgColor
//        self.backGroundView.layer.masksToBounds = true
//
//        self.layer.shadowOpacity = 0.18
//        self.layer.shadowOffset = CGSize(width: 0, height: 2)
//        self.layer.shadowRadius = 2
//        self.layer.shadowColor = Colors.colorBlack.cgColor
//        self.layer.masksToBounds = false
        
//        self.contentView.layer.cornerRadius = 5.0
//        self.contentView.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
//        self.contentView.layer.borderWidth = 0.5
//
//
//        let border = CALayer()
//        let width = CGFloat(2.0)
//        border.borderColor = UIColor.darkGray.cgColor
//        border.frame = CGRect(x: 0, y: self.contentView.frame.size.height - width, width:  self.contentView.frame.size.width, height: self.contentView.frame.size.height)
//
//        border.borderWidth = width
//        self.contentView.layer.addSublayer(border)
//        self.contentView.layer.masksToBounds = true
//        self.contentView.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

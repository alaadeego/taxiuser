//
//  searchResultTableViewCell.swift
//  Mashy
//
//  Created by Amal Khaled on 12/4/17.
//  Copyright © 2017 amany. All rights reserved.
//

import UIKit

class searchResultTableViewCell: UITableViewCell {

  
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

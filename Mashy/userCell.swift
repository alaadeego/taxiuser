//
//  userCell.swift
//  Mashy
//
//  Created by amany on 11/1/17.
//  Copyright © 2017 amany. All rights reserved.
//

import UIKit

class userCell: UITableViewCell {


    @IBOutlet var user_title: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }

}

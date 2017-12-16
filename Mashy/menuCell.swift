//
//  menuCell.swift
//  queen
//
//  Created by amany on 6/27/16.
//
//

import UIKit

class menuCell: UITableViewCell {

    @IBOutlet var menu_title: UILabel!
    @IBOutlet var menu_image: UIImageView!
    @IBOutlet var menu_line: UIView!
    

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

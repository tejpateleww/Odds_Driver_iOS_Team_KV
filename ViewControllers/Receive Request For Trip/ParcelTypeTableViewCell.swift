//
//  ParcelTypeTableViewCell.swift
//  ODDS-Driver
//
//  Created by Mayur iMac on 16/05/19.
//  Copyright © 2019 Excellent Webworld. All rights reserved.
//

import UIKit

class ParcelTypeTableViewCell: UITableViewCell {

    @IBOutlet weak var lblParcelNumberTitle: UILabel!
    @IBOutlet weak var lblParcelType: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

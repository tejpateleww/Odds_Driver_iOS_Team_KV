//
//  PendingParcelTableViewCell.swift
//  ODDS-Driver
//
//  Created by EWW076 on 09/04/19.
//  Copyright © 2019 Excellent Webworld. All rights reserved.
//

import UIKit

class PendingParcelTableViewCell: UITableViewCell {
    @IBOutlet weak var lblParcelId : UILabel!
    @IBOutlet weak var lblParcelSize : UILabel!
    @IBOutlet weak var lblParcelWeight : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

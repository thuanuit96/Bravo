//
//  SettingTableViewCell.swift
//  Demo
//
//  Created by asto on 1/25/19.
//  Copyright © 2019 asto. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var bntLogout: UIButton!
    @IBOutlet weak var lbAccount: UILabel!
    @IBOutlet weak var lbChangeLg: UILabel!
    @IBOutlet weak var btnChangeLg: UIButton!
    
}

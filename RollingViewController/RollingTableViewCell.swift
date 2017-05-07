//
//  RollingTableViewCell.swift
//  RollingViewController
//
//  Created by Muronaka Hiroaki on 2017/05/06.
//  Copyright © 2017年 Muronaka Hiroaki. All rights reserved.
//

import UIKit

class RollingTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

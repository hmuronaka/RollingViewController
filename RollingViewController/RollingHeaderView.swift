//
//  RollingHeaderView.swift
//  RollingViewController
//
//  Created by Muronaka Hiroaki on 2017/05/06.
//  Copyright © 2017年 Muronaka Hiroaki. All rights reserved.
//

import UIKit

class RollingHeaderView: UIView {

    @IBOutlet weak var headerImageView: UIImageView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    init() {
        super.init(frame: CGRect.zero)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    static func createFromNib() -> RollingHeaderView {
        let view = Bundle.main.loadNibNamed("RollingHeaderView", owner: self, options: nil)?[0] as! RollingHeaderView
        return view
    }
}

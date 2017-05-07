//
//  CGRect+RollingViewController.swift
//  RollingViewController
//
//  Created by MuronakaHiroaki on 2017/05/07.
//  Copyright © 2017年 Muronaka Hiroaki. All rights reserved.
//

import UIKit

extension CGRect {
    
    var top:CGFloat {
        return self.origin.y
    }
    
    var bottom:CGFloat {
        return self.height + self.origin.y
    }
    
    
}

//
//  UITableView+RollingViewController.swift
//  RollingViewController
//
//  Created by Muronaka Hiroaki on 2017/05/07.
//  Copyright © 2017年 Muronaka Hiroaki. All rights reserved.
//

import UIKit

extension UITableView {
    
    func reloadData(then: () ->()) {
        self.reloadData()
        then()
    }
    
    func ts_rectFromParent(at indexPath:IndexPath) -> CGRect {
        let rect = self.rectForRow(at: indexPath)
        return self.convert(rect, to: self.superview)
    }
}

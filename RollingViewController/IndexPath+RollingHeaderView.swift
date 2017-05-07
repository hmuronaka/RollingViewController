//
//  IndexPath+RollingHeaderView.swift
//  RollingViewController
//
//  Created by Muronaka Hiroaki on 2017/05/07.
//  Copyright © 2017年 Muronaka Hiroaki. All rights reserved.
//

import UIKit 

extension IndexPath {
    
    func previousRow(at offset:Int = 1) -> IndexPath? {
        guard self.row - offset >= 0 else {
            return nil
        }
        return IndexPath(row: self.row - offset, section: self.section)
    }
    
    func nextRow(numRows: Int, at offset: Int = 1) -> IndexPath? {
        guard self.row + offset < numRows else {
            return nil
        }
        return IndexPath(row: self.row + offset, section: self.section)
    }
    
}

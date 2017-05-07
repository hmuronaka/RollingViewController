//
//  UIView+RollingViewController.swift
//  RollingViewController
//
//  Created by Muronaka Hiroaki on 2017/05/07.
//  Copyright © 2017年 Muronaka Hiroaki. All rights reserved.
//
import UIKit

extension UIView {
    
    var top: CGFloat {
        return self.frame.origin.y
    }
    
    var bottom: CGFloat {
        return self.frame.origin.y + self.frame.height
    }
    
    func ts_toImage(opaque:Bool = true) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, opaque, 0);
        
        let context = UIGraphicsGetCurrentContext()!
        
        // 透明にする場合, contextを変更するのでsaveしておく。
        if !opaque {
            context.saveGState()
            UIColor.clear.set()
        }
        self.layer.render(in: context)
        
        let image:UIImage! = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        if !opaque {
            context.restoreGState()
        }
        
        return image;
    }
    
    
}

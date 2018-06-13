//
//  UIScreen+Extension.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/23.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

extension UIDevice {
    public func isX() -> CGFloat {
        if UIScreen.main.bounds.height == 812 {
            return 34
        }
        
        return 0
    }
}

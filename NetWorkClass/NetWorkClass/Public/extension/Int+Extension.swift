//
//  Int+Extension.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/23.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

extension Int{
    func string() -> String{
        return "\(self)"
    }
    
    
    func ABCD() -> String {
        switch self {
        case 0:
            return "A"
        case 1:
            return "B"
        case 2:
            return "C"
        case 3:
            return "D"
        case 4:
            return "E"
        case 5:
            return "F"
        case 6:
            return "G"
        case 7:
            return "H"
        default:
            return "I"
        }
    }
}

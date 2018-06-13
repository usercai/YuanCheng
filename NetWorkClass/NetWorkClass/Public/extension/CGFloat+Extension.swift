//
//  CGFloat+Extension.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/22.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

extension CGFloat{
    
    func c_String() -> String{
        
        return "\(self)"
    }
    
    func c_StringTime() -> String {
        
        
        let hour = Int(self/3600)
        let minute = Int((self.truncatingRemainder(dividingBy: 3600))/60)
        let second = Int(self.truncatingRemainder(dividingBy: 60))
        

        if hour == 0 {
            return String(format: "%02d:%02d", arguments: [minute,second])
        }
        
        return String(format: "%02d:%02d:%02d", arguments: [hour,minute,second])
        
    }
}

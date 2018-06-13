//
//  NSMutableArray+Extension.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/4.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

extension NSMutableArray{
    
    
    func toJson() -> String {
        
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
            return String.init(data: data, encoding: String.Encoding.utf8) ?? ""
            
        } catch  {
            
        }
        
        return ""

    }
}

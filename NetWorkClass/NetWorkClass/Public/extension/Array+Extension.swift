//
//  Array+Extension.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/9.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

extension Array{
    
    func ImageArrtoString() -> String {
        

        var str = ""
        
        if let array = self as? [Model_Path] {
            
            for (index,model) in array.enumerated() {
                var dic:[String:String] = [:]
                dic["ContentAddress"] = model.path
                
                if index == array.count - 1{
                    str = str + dic.getJSONStringFromDictionary()

                }else{
                    str = str + dic.getJSONStringFromDictionary() + ","

                }
                
            }
        }
        
        
        return "[" + str + "]"
    }
    
    
    func ABCD() -> String {
       
        let strArr = self.map { (intstr) -> String in
            if let int = intstr as? Int{
                return int.ABCD()
            }
            return ""
        }
        var daan = ""
        
        for str in strArr {
            daan = daan + str
        }
        
        return daan
        
    }
    
}

//
//  Dictionary+Extension.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/9.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

extension Dictionary{
    
    
    /**
     字典转换为JSONString
     
     - parameter dictionary: 字典参数
     
     - returns: JSONString
     */
    func getJSONStringFromDictionary() -> String {
        if (!JSONSerialization.isValidJSONObject(self)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: self, options: []) as NSData!
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return (JSONString ?? "") as String
    }
    
}

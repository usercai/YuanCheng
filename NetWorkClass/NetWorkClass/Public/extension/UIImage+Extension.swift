//
//  UIImage+Extension.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/20.
//  Copyright © 2017年 thc. All rights reserved.
//

import Foundation
import UIKit

extension UIImage{
    
    func createImageWithColor(color:UIColor)->UIImage{
        
        let rect = CGRect.init(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!

    }
    
    func base64() -> String {
        
        // 将图片转化成Data
        let imageData = UIImageJPEGRepresentation(self, 0.1)
        
        // 将Data转化成 base64的字符串
        let imageBase64String = imageData?.base64EncodedString()
        
        return imageBase64String ?? ""
    }
}

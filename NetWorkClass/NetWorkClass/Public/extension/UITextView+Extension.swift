//
//  UITextView+Extension.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/12.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

extension UITextView{
    
    func setC_placeHolerLabel(hc_placeHolerLabel:String) {
        let label = UILabel()
        label.text = hc_placeHolerLabel
        label.numberOfLines = 0
        label.textColor = RGB(R: 201, G: 201, B: 207)
        label.sizeToFit()
        self.addSubview(label)
        label.font = self.font
        self.setValue(label, forKey: "_placeholderLabel")
    }
    
    func C_placeHolerLabel()->String{
        
        if let label = self.value(forKey: "_placeholderLabel") as? UILabel {
            return label.text ?? ""
        }
        
        return ""
        
    }
}

//
//  Color.swift
//  SwiftFrame
//
//  Created by mac on 2017/11/6.
//  Copyright © 2017年 thc. All rights reserved.
//

import Foundation
import UIKit
import Hue

public let color = [["#ff8a28","#fea964","#fdc596"],["#2ca5ff","#5cb9fd","#8acdfd"],["#ff545c","#fe8188","#ffabae"]]

/// 主题色
public let TINTCOLOR = UIColor(red: 30/255.0, green: 96/255.0, blue: 161/255.0, alpha: 1.0)

public let BackBlueColor = UIColor(hex: "#e5f2ff")
public let CalenderBack = UIColor.init(hex: "#0080d1")

public let LineColor_d9d9d9 = UIColor(hex: "#d9d9d9")

///背景色
public let BG_COLOR=UIColor(red: 255/225.0, green: 255/225.0, blue: 255/225.0, alpha: 1.0)
///输入框的placeholderColor
public let PlaceholderColor=UIColor(red: 204/225.0, green: 204/225.0, blue: 204/225.0, alpha: 1.0)
public let LineColor = UIColor(red: 217/225.0, green: 217/225.0, blue: 217/225.0, alpha: 1.0)
public let WHITEColor = UIColor.white
public let ClearColor = UIColor.clear

public let TextColor = UIColor.init(hex: "#333333")
public let TextColor999999 = UIColor.init(hex: "#999999")

public func RGB(R:CGFloat,G:CGFloat,B:CGFloat) -> UIColor {
    return UIColor.init(red: R/255.0, green: G/255.0, blue: B/255.0, alpha: 1)
}

//返回随机颜色
public var randomColor: UIColor {
    get {
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

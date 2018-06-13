//
//  Defines.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/18.
//  Copyright © 2017年 thc. All rights reserved.
//

import Foundation
import UIKit

var KUserInfo = UserInfo.shareInstance

public let KEY_Chain:String = "NetWorkClassKeyChain"
public let KEY_PASSWORD = "PassWord"
public let KEY_USERACCOUNT = "UserAccount"
public let KEY_LOGINTYPE = "LoginType"
public let KEY_USERTYPE = "UserType"


public let APPDelegate = UIApplication.shared.delegate
public let KWindow = UIApplication.shared.keyWindow
/*********尺寸***********/

///设备屏幕尺寸
public let SCREEN_WIDTH = UIScreen.main.bounds.size.width
public let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

public let AppVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String


///获取视图尺寸
public func VIEW_WIDTH(view:UIView)->CGFloat{
    return view.frame.size.width
}
public func VIEW_HEIGHT(view:UIView)->CGFloat{
    return view.frame.size.height
}

public let isPhoneX = UIScreen.main.bounds.size.height == 812 ? true : false
public let iPhone6 = UIScreen.main.bounds.size.height == 667 ? true : false
public let iPhone6P = UIScreen.main.bounds.size.height == 736 ? true : false
public let iPhone5S = UIScreen.main.bounds.size.height <= 568.0 ? true : false


public let NaviBarHeight:CGFloat = isPhoneX ? 88 : 64

public let TabBarHeight:CGFloat = isPhoneX ? 49+34 : 49

public let StateBarHeight:CGFloat = isPhoneX ? 24 : 0

public let TabStateBarHeight:CGFloat = isPhoneX ? 34 : 0

public let CFont_10 = UIFont.systemFont(ofSize: 10)
public let CFont_11 = UIFont.systemFont(ofSize: 11)
public let CFont_12 = UIFont.systemFont(ofSize: 12)
public let CFont_13 = UIFont.systemFont(ofSize: 13)
public let CFont_14 = UIFont.systemFont(ofSize: 14)
public let CFont_15 = UIFont.systemFont(ofSize: 15)
public let CFont_16 = UIFont.systemFont(ofSize: 16)
public let CFont_17 = UIFont.systemFont(ofSize: 17)
public let CFont_18 = UIFont.systemFont(ofSize: 18)




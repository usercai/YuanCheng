//
//  AppDelegate+IQKeyboardManager.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/13.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import IQKeyboardManager

extension AppDelegate{
    
    func setpodIQKeyboardSetting(){
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().isEnableAutoToolbar = true
        IQKeyboardManager.shared().toolbarDoneBarButtonItemText = "完成"
        IQKeyboardManager.shared().keyboardDistanceFromTextField = 10
        IQKeyboardManager.shared().preventShowingBottomBlankSpace = false
        IQKeyboardManager.shared().shouldShowToolbarPlaceholder = true
        IQKeyboardManager.shared().placeholderFont = CFont_14
        ///点击背景下去
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        IQKeyboardManager.shared().preventShowingBottomBlankSpace = false

    }
}

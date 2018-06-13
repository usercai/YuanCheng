//
//  AppDelegate.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/17.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.window?.backgroundColor = UIColor.white
        
        self.window?.rootViewController = StartViewController()
        
        /// 注册极光推送
        self.registerPush(launchOptions: launchOptions)
        /// 设置keyboard
        self.setpodIQKeyboardSetting()
        ///监听网络状态
        CNetWrokReachabilityManager.share.startListen()
        return true
    }

}


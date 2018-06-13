//
//  UIViewController+Extension.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/4.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

extension UIViewController{
    
    class func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
    
    func setNaviForClear(){
        if self.navigationController != nil {
            // 1.设置导航栏标题属性：设置标题颜色
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
            // 2.设置导航栏前景色：设置item指示色
            self.navigationController?.navigationBar.tintColor = TextColor
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 16),NSAttributedStringKey.foregroundColor:TextColor]

            // 3.设置导航栏半透明
            self.navigationController?.navigationBar.isTranslucent = true
            
            // 4.设置导航栏背景图片
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            
            // 5.设置导航栏阴影图片
            self.navigationController?.navigationBar.shadowImage = UIImage()
        }
    }
    
}

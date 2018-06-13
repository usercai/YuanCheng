//
//  BaseNaviViewController.swift
//  SwiftFrame
//
//  Created by mac on 2017/11/16.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class BaseNaviViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavi()
    }

    func initNavi() {
        
        let bar = self.navigationBar
        bar.tintColor = WHITEColor
        bar.isTranslucent = false
        bar.titleTextAttributes = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 18),NSAttributedStringKey.foregroundColor:WHITEColor]
        bar.barTintColor = TINTCOLOR
        
        
        
    }
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        //重写左侧返回按钮
        if self.childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: true )
        
        if self.viewControllers.count > 1 && viewController.navigationItem.leftBarButtonItem == nil {
            
            let backImage = #imageLiteral(resourceName: "Navibar_back")
            let barbtn = UIBarButtonItem(image: backImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(poplaseController))
            viewController.navigationItem.leftBarButtonItem = barbtn

        }



    }

    @objc func poplaseController() {
        self.popViewController(animated: true)
    }
    
}

//
//  BaseTabbarController.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/17.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class BaseTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
    
}

extension BaseTabbarController{
    
    func initView(){
        
        let viewControllers = [HomePageViewController(),TestLibraryViewController(),ClassRoomViewController(),MeViewController()]
        let titles = ["首页","题库","课堂","我的"]
        let SelectImage = ["shouye","tiku","ketang","wode"]
        let images = ["shouye1","tiku1","ketang1","wode1"]
        
        for i in 0..<viewControllers.count {
            SetTabBar(vc: viewControllers[i], title: titles[i], image: images[i], selectImage: SelectImage[i])
        }
    }
    
    func SetTabBar(vc:UIViewController,title:String,image:String,selectImage:String)  {
        
        vc.navigationItem.title = title
        vc.view.backgroundColor = UIColor.white
        vc.tabBarItem.title = title
        let image = UIImage.init(named: image)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        let selectiamge = UIImage.init(named: selectImage)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        
        vc.tabBarItem.image = image
        vc.tabBarItem.selectedImage = selectiamge
        
        let navi = BaseNaviViewController(rootViewController: vc)
        
        self.addChildViewController(navi)
    }
}

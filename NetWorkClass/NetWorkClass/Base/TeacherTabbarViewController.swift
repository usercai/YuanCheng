//
//  TeacherTabbarViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/14.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class TeacherTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension TeacherTabbarViewController{
    
    func initView(){
        
        let viewControllers = [TC_HomePageViewController(),ApproveViewController(),MeViewController()]
        let titles = ["首页","审批","我的"]
        let SelectImage = ["shouye","shenpi","wode"]
        let images = ["shouye1","shenpi1","wode1"]
        
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

//
//  AppTool.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/5.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import ImageViewer

struct DataItem {
    
    let imageView: UIImageView
    let galleryItem: GalleryItem
}




class AppTool: NSObject {

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
    
    
    /// 传入ImageView
    ///
    /// - Parameter images:
    /// - Returns:
    class func setImageForDataItem(images:[UIImageView]) -> [DataItem] {
        var item:[DataItem] = []
        
        for (index, imageView) in images.enumerated() {
            
            var galleryItem: GalleryItem!
                            
            let image = imageView.image ?? #imageLiteral(resourceName: "noDataImage")
            galleryItem = GalleryItem.image { $0(image) }

            item.append(DataItem(imageView: imageView, galleryItem: galleryItem))
        }
        return item
    }

    
    
    class func galleryConfiguration() -> GalleryConfiguration {
        
        return [
            

            
            GalleryConfigurationItem.deleteButtonMode(.none),
            GalleryConfigurationItem.seeAllCloseButtonMode(.none),
            
            GalleryConfigurationItem.seeAllCloseLayout(ButtonLayout.pinLeft(NaviBarHeight, 20)),
            GalleryConfigurationItem.deleteLayout(ButtonLayout.pinRight(NaviBarHeight, 20))
            
        ]
    }

    class func CisEmpty(str:String?)->Bool{
        guard let string = str else {
            return false
        }
        return string == "" || string == "null"

    }
    
    /// 将颜色转换为图片
    ///
    /// - Parameter color: 
    /// - Returns:
    class func getImageWithColor(color:UIColor)->UIImage{
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

    class func showAlert(VC:UIViewController?=nil,title:String,QAction:@escaping ()->()) {
        let alertcontroller = UIAlertController(title: title, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let alertAction1 = UIAlertAction(title: "确定", style: UIAlertActionStyle.default) { (action) in
            QAction()
        }
        let alertAction2 = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        alertcontroller.addAction(alertAction1)
        alertcontroller.addAction(alertAction2)
        if VC == nil {
            AppTool.currentViewController()?.present(alertcontroller, animated: true, completion: nil)
        }else{
            VC?.present(alertcontroller, animated: true, completion: nil)
        }
    }
    class func showAlert(VC:UIViewController?=nil,title:String,QAction:@escaping ()->(),cancel:@escaping ()->()) {
        let alertcontroller = UIAlertController(title: title, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let alertAction1 = UIAlertAction(title: "确定", style: UIAlertActionStyle.default) { (action) in
            QAction()
        }
        let alertAction2 = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (can) in
            cancel()
        }
        alertcontroller.addAction(alertAction1)
        alertcontroller.addAction(alertAction2)
        if VC == nil {
            AppTool.currentViewController()?.present(alertcontroller, animated: true, completion: nil)
        }else{
            VC?.present(alertcontroller, animated: true, completion: nil)
        }
    }
    
    /// 弹出ActionSheet
    ///
    /// - Parameters:
    ///   - VC: 当前的VC
    ///   - title: 标题
    ///   - actions: 每个Action的数据
    ///   - QAction: 回调
    class func showAlertSheet(VC:UIViewController?=nil,title:String,actions:[Model_GradeSubject],QAction:@escaping (Model_GradeSubject)->()) {
        let alertcontroller = UIAlertController(title: title, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        for item in actions {
            let alertAction = UIAlertAction(title: item.GradeName+item.SubjectName, style: UIAlertActionStyle.default) { (action) in
                QAction(item)
            }
            alertcontroller.addAction(alertAction)
        }
        
        let cancle = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (action) in

        }
        alertcontroller.addAction(cancle)
        
        if VC == nil {
            AppTool.currentViewController()?.present(alertcontroller, animated: true, completion: nil)
        }else{
            VC?.present(alertcontroller, animated: true, completion: nil)
        }
    }
    
    class func getLauchImage() -> UIImage {
        let size = UIScreen.main.bounds.size
        let orientation = "Portrait"
        var launchImage = ""
        guard let bundledic = Bundle.main.infoDictionary else {
            return #imageLiteral(resourceName: "AppLaunch")
        }
        guard let imagesDict = bundledic["UILaunchImages"] else {
            return #imageLiteral(resourceName: "AppLaunch")
        }
        guard let imgdic = imagesDict as? [Any] else {
            return #imageLiteral(resourceName: "AppLaunch")
        }
        for dict in imgdic {
            guard let dic = dict as? Dictionary<String,Any> else{
                return #imageLiteral(resourceName: "AppLaunch")
            }
            let imagesize = CGSizeFromString(dic["UILaunchImageSize"] as! String)
            if size == imagesize && (dic["UILaunchImageOrientation"] as! String) == orientation{
                launchImage = dic["UILaunchImageName"] as! String
            }
        }
        
        return UIImage.init(named: launchImage) ?? #imageLiteral(resourceName: "AppLaunch")

        
    }
    
}

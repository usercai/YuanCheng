//
//  CProgressHUD.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/24.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import MBProgressHUD
import NVActivityIndicatorView


class CProgressHUD: NSObject {

    
    class func showError(error:String){

        showText(text: error)
    }
    
    class func showText(text:String) {
        

        CProgressHUD.hiddenLoading()
        
        DispatchQueue.main.async {
            
            let hud = MBProgressHUD.showAdded(to: KWindow!, animated: true)
            //关闭点击
            hud.isUserInteractionEnabled = false
            //背景
            hud.bezelView.backgroundColor = UIColor.black.alpha(0.8)
            //最小宽高
            hud.minSize = CGSize(width: 100, height: 0)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = text
            hud.label.font = CFont_16
            hud.label.textColor = WHITEColor
            hud.label.numberOfLines = 0
            
            hud.offset = CGPoint(x: 0, y: SCREEN_HEIGHT/3)
            //圆角
            hud.bezelView.layer.cornerRadius = 5
            hud.bezelView.clipsToBounds = true
            //边距
            hud.margin = 15
            hud.hide(animated: true, afterDelay: 1)
            hud.removeFromSuperViewOnHide = true
            
            
        }
        
    }
    

    
    class func showLoading() {
        
        if LoadingHud.shared.loadhud == nil {
            LoadingHud.shared.loadhud = NVActivityIndicatorView(frame: CGRect.init(x: SCREEN_WIDTH/2 - 40, y: SCREEN_HEIGHT/2-40, width: 80, height: 80), type: NVActivityIndicatorType.ballBeat, color: WHITEColor, padding: 20)
            
        }
        KWindow?.addSubview(LoadingHud.shared.loadhud!)
        LoadingHud.shared.loadhud?.startAnimating()
    }
    class func hiddenLoading() {
        if LoadingHud.shared.loadhud == nil {

            return
        }
        LoadingHud.shared.loadhud?.stopAnimating()
    }
    

}

fileprivate class LoadingHud: NSObject {
    static let shared = LoadingHud.init()
    public var loadhud:NVActivityIndicatorView? = nil
    private override init() {
        super.init()
        let loadhud = NVActivityIndicatorView(frame: CGRect.init(x: SCREEN_WIDTH/2 - 40, y: SCREEN_HEIGHT/2-80, width: 80, height: 80))
        loadhud.type = .ballBeat
        loadhud.padding = 20
        loadhud.color = UIColor.black.alpha(0.5)
        self.loadhud = loadhud
    }
}

fileprivate class ProgressHud:NSObject{
    
}






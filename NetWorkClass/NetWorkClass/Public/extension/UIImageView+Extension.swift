//
//  UIImageView+Extension.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/24.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView{
    
    func c_setImage(url:String){
        if url.contains("http") {
            self.sd_setImage(with: url.url(), placeholderImage: #imageLiteral(resourceName: "noDataImage"), options: SDWebImageOptions.progressiveDownload, completed: nil)

        }
        self.sd_setImage(with: url.UrlStr().url(), placeholderImage: #imageLiteral(resourceName: "noDataImage"), options: SDWebImageOptions.progressiveDownload, completed: nil)
    }
    
    func c_setImage(url:String,placeholderImage:UIImage) {
        if url.contains("http") {
            self.sd_setImage(with: url.url(), placeholderImage: placeholderImage, options: SDWebImageOptions.progressiveDownload, completed: nil)

        }
        self.sd_setImage(with: url.UrlStr().url(), placeholderImage: placeholderImage, options: SDWebImageOptions.progressiveDownload, completed: nil)

    }
    
}

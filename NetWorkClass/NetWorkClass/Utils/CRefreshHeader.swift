
//
//  CRefreshHeader.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/24.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import MJRefresh

class CRefresh: MJRefreshGifHeader {

    typealias RefreshBlock = ()->()
    typealias footRefresh = ()->()
    
    class func headerRefresh(refresh:@escaping RefreshBlock) -> MJRefreshGifHeader{
        let header = MJRefreshGifHeader.init {
            refresh()
        }
        
//        header?.lastUpdatedTimeLabel.isHidden = true
//        header?.stateLabel.isHidden = true
        return header!
    }
    

    class func footerRefresh(refresh:@escaping footRefresh)-> MJRefreshBackGifFooter {
        
        let foot = MJRefreshBackGifFooter.init {
            refresh()
        }
        return foot!
        
    }
}

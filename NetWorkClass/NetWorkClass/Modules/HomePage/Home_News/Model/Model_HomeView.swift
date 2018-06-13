//
//  Model_HomeView.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/23.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import ObjectMapper
import RxDataSources

struct Model_HomeView:Mappable {
    
    var NoticeID = 0
    var Title = ""
    var Contents = ""
    var Summary = ""
    var Author = ""
    var CreateDateTime = ""
    var Picture = ""
    var NoticeType = 0
    var IsCarousel = 0
    
    mutating func mapping(map: Map) {
        
        NoticeID <- map["NoticeID"]
        Title <- map["Title"]
        Contents <- map["Contents"]
        Summary <- map["Summary"]
        Author <- map["Author"]
        CreateDateTime <- map["CreateDateTime"]
        Picture <- map["Picture"]
        NoticeType <- map["Type"]
        IsCarousel <- map["IsCarousel"]
    }
    
    init?(map: Map) {
        
    }
}

struct Section_HomeView{
    
    var items : [Item]
    
}

extension Section_HomeView : SectionModelType{
    
    typealias Item = Model_HomeView
    
    init(original:Section_HomeView,items:[Model_HomeView]) {
        self = original
        self.items = items
    }
    

}

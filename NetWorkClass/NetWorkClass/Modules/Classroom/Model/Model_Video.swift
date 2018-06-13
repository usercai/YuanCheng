//
//  Model_Video.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/29.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import ObjectMapper

struct Model_Video: Mappable {

    mutating func mapping(map: Map) {
        VideoID <- map["VideoID"]
        VideoType <- map["VideoType"]
        Picture <- map["Picture"]
        FileTitle <- map["FileTitle"]
        CreateTime <- map["CreateTime"]
        VideoContent <- map["VideoContent"]
    }
    
    init?(map: Map) {
    }
    
    var VideoID = 0
    var VideoType = 0
    var Picture = ""
    var FileTitle = ""
    var CreateTime = ""
    var VideoContent = ""

}

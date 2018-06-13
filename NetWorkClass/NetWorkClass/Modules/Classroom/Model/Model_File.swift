//
//  Model_File.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/29.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import ObjectMapper
struct Model_File: Mappable {

    mutating func mapping(map: Map) {
        FilesID <- map["FilesID"]
        FileType <- map["FileType"]
        ChapterID <- map["ChapterID"]
        Picture <- map["Picture"]
        FileTitle <- map["FileTitle"]
        FileContent <- map["FileContent"]
    }
    init?(map: Map) {
    }
    var FilesID = 0
    var FileType = 0
    var ChapterID = 0
    var Picture = ""
    var FileContent = ""
    var FileTitle = ""
    
    
}

//
//  Model_Class.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/27.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import ObjectMapper

struct Model_Class: Mappable {

    /**
     "ClassesID": 4,
     "ClassesName": "精英班",
     "SchoolYearID": 4
     */
    
    var ClassesID = 0
    var ClassesName = "精英班"
    var SchoolYearID = 0
    
    mutating func mapping(map: Map) {
        
        ClassesID <- map["ClassesID"]
        ClassesName <- map["ClassesName"]
        SchoolYearID <- map["SchoolYearID"]
    }
    init?(map: Map) {
        
    }
}

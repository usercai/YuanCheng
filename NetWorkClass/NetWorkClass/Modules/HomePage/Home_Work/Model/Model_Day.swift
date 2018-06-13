//
//  Model_Day.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/30.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import ObjectMapper
struct Model_Day: Mappable {

    mutating func mapping(map: Map) {
        day <- map["day"]
    }
    init?(map: Map) {
    }
    var day = 0
    
}

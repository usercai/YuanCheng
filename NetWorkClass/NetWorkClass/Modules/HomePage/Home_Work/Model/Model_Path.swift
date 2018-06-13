//
//  Model_Path.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/2.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import ObjectMapper

struct Model_Path : Mappable{

    mutating func mapping(map: Map) {
     
        path <- map["path"]
    }
    init?(map: Map) {
        
    }
    var path = ""
    
}

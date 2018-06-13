//
//  Model_DoHomeWork.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/21.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import ObjectMapper
struct Model_DoHomeWork:Mappable{
    
    mutating func mapping(map: Map) {
        homework <- map["homework"]
        homeworkbody <- map["homeworkbody"]
    }
    init?(map: Map) {
        
    }
    var homework:[Model_HomeWork] = []
    var homeworkbody:[Model_WorkBody] = []
    
}

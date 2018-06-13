//
//  Model_Grade.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/27.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import ObjectMapper
class Model_Grade: Mappable {

    required init?(map: Map) {
    }
    func mapping(map: Map) {
        GradeID <- map["GradeID"]
        GradeName <- map["GradeName"]
        
        
    }
    var GradeID = 0
    var GradeName = ""
    
    
    
}

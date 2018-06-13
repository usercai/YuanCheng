//
//  Subject.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/24.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import ObjectMapper

class Model_Subject: Mappable {

    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        SubjectID <- map["SubjectID"]
        SubjectName <- map["SubjectName"]
        Icon <- map["Icon"]
    }
    var SubjectID = 2
    var SubjectName = ""
    var Icon = ""
    
    
}

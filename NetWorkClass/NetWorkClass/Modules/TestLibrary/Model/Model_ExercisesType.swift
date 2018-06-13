
//
//  Model_ExercisesType.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/27.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import ObjectMapper

class Model_ExercisesType: Mappable {
    
    /**
     "QuestionTypeID": 2,
     "TypeName": "多选",
     "IsDelete": 0,
     "FixedType": "2"
     */
    var QuestionTypeID = 0
    var TypeName = ""
    var IsDelete = 0
    var FixedType = ""
    var Count = 0
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        QuestionTypeID <- map["QuestionTypeID"]
        TypeName <- map["TypeName"]
        IsDelete <- map["IsDelete"]
        FixedType <- map["FixedType"]
        Count <- map["Count"]
    }
    

    
}

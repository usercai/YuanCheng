//
//  Model_Exam.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/4.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import ObjectMapper
struct Model_Exam: Mappable {

    mutating func mapping(map: Map) {
        ExamID <- map["ExamID"]
        ExamName <- map["ExamName"]
        ExamTime <- map["ExamTime"]
        TotalScore <- map["TotalScore"]
        SubjectID <- map["SubjectID"]
        Count <- map["Count"]
        IsRead <- map["IsRead"]
        CreateTime <- map["CreateTime"]
    }
    init?(map: Map) {
        
    }
    var ExamID = 0
    var ExamName = ""
    var ExamTime = 0
    var TotalScore = 0
    var SubjectID = 0
    var Count = 0
    var IsRead = 0
    var CreateTime = ""
    
}

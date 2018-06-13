//
//  Model_TestPaper.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/27.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import ObjectMapper

/// 模拟题列表
class Model_TestPaper: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        ExamID <- map["ExamID"]
        ExamName <- map["ExamName"]
        ExamTime <- map["ExamTime"]
        TotalScore <- map["TotalScore"]
        TeacherID <- map["TeacherID"]
        GradeID <- map["GradeID"]
        SubjectID <- map["SubjectID"]
        Count <- map["Count"]
        StuName <- map["StuName"]
        StudentID <- map["StudentID"]
        IsRead <- map["IsRead"]
    }
    

    /**
     "ExamID": 6,
     "ExamName": "数学练习",
     "ExamTime": 90,
     "TotalScore": 120,
     "TeacherID": 15,
     "GradeID": 3,
     "SubjectID": 3
     */
    
    var ExamID = 0
    var ExamName = "数学练习"
    var ExamTime = 0
    var TotalScore = 0
    var TeacherID = 0
    var GradeID = 0
    var SubjectID = 0
    var Count = 0
    var StuName = ""
    var StudentID = 0
    var IsRead = 1
    
}

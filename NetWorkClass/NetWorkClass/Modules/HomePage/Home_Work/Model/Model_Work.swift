//
//  Model_Work.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/30.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import ObjectMapper
struct Model_Work: Mappable {
    
/**
     [
     {
     "SubjectID": 2,
     "SubjectName": "语文",
     "GradeID": null,
     "GradeName": null,
     "SchoolYearID": null,
     "HomeworkList": [
     {
     "HomeworkID": 2,
     "SchoolYearID": 2,
     "SchoolYearName": "2017学年",
     "GradeID": 3,
     "GradeName": "一年级",
     "SubjectID": 2,
     "SubjectName": "语文",
     "HomeworkDate": "2017-11-24T00:00:00",
     "HomeworkTitle": "34dsafsf",
     "HomeworkImg": "/UploadFiles/HomeworkImg/image/20171118/20171118175738_8956_small.png"
     },
     {
     "HomeworkID": 7,
     "SchoolYearID": 2,
     "SchoolYearName": "2017学年",
     "GradeID": 3,
     "GradeName": "一年级",
     "SubjectID": 2,
     "SubjectName": "语文",
     "HomeworkDate": "2017-11-24T00:00:00",
     "HomeworkTitle": "333",
     "HomeworkImg": ""
     }
     ]
     }
     ]
     */
    mutating func mapping(map: Map) {
        SubjectName <- map["SubjectName"]
        SubjectID <- map["SubjectID"]
        HomeworkList <- map["HomeworkList"]
    }
    init?(map: Map) {
    }
    var SubjectName = ""
    var SubjectID = 0
    var HomeworkList:[Model_WorkBody] = []
    
    
    
}

struct Model_WorkBody : Mappable {
    mutating func mapping(map: Map) {
        HomeworkImg <- map["HomeworkImg"]
        HomeworkTitle <- map["HomeworkTitle"]
        HomeworkID <- map["HomeworkID"]
        HomeworkDate <- map["HomeworkDate"]
        HomeworkBodyID <- map["HomeworkBodyID"]
        HomeworkFiles <- map["HomeworkFiles"]
        CreateDataTime <- map["CreateDataTime"]
    }
    init?(map: Map) {
        
    }
    var HomeworkImg = ""
    var HomeworkTitle = ""
    var HomeworkID = 0
    var HomeworkDate = ""
    var CreateDataTime = ""
    var HomeworkBodyID = 0
    var HomeworkFiles:[Model_HomeWorkStuAnswerImg] = []
}

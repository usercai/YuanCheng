//
//  Model_HomeWork.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/4.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import ObjectMapper

struct Model_HomeWork: Mappable {

    mutating func mapping(map: Map) {
        HomeworkID <- map["HomeworkID"]
        HomeworkId <- map["HomeworkId"]
        SubjectId <- map["SubjectId"]
        SubjectName <- map["SubjectName"]
        HomeworkDate <- map["HomeworkDate"]
        HomeworkTitle <- map["HomeworkTitle"]
        HomeworkImg <- map["HomeworkImg"]
        StuName <- map["StuName"]
        CreateDataTime <- map["CreateDataTime"]
        HomeworkFiles <- map["HomeworkFiles"]
        Comment <- map["Comment"]
        IsRead <- map["IsRead"]
        HomeworkBodyID <- map["HomeworkBodyID"]
        StudentID <- map["StudentID"]
    }
    init?(map: Map) {
        
    }
    var HomeworkID = 0
    var HomeworkId = 0
    var SubjectId = 0
    var SubjectName = ""
    var HomeworkDate = ""
    var HomeworkTitle = ""
    var HomeworkImg = ""
    var StuName = ""
    var CreateDataTime = ""
    var HomeworkFiles:[Model_HomeWorkStuAnswerImg] = []
    var Comment = ""
    var IsRead = 0
    var HomeworkBodyID = 0
    var StudentID = 0
    
}
struct Model_HomeWorkStuAnswerImg:Mappable {
    var ContentAddress = ""
    var HomeworkBodyID = 0
    var HomeworkFilesID = 0
    
    mutating func mapping(map: Map) {
        ContentAddress <- map["ContentAddress"]
        HomeworkBodyID <- map["HomeworkBodyID"]
        HomeworkFilesID <- map["HomeworkFilesID"]
    }
    init?(map: Map) {
        
    }
}

struct Model_HomeWorkInfo:Mappable{
    mutating func mapping(map: Map) {
        HomeworkTitle <- map["HomeworkTitle"]
        HomeWorkImg <- map["HomeWorkImg"]
        CreateDataTime <- map["CreateDataTime"]
        Comment <- map["Comment"]
        childs <- map["childs"]
    }
    init?(map: Map) {
        
    }
    var HomeworkTitle = ""
    var HomeWorkImg = ""
    var CreateDataTime = ""
    var Comment = ""
    var childs:[Model_HomeWorkInfoMyQuestion] = []
}

struct Model_HomeWorkInfoMyQuestion:Mappable {
    mutating func mapping(map: Map) {
        ContentAddress <- map["ContentAddress"]
    }
    init?(map: Map) {
        
    }
    var ContentAddress = ""
    
}

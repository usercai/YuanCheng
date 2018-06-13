//
//  Model_Chapter.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/24.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import ObjectMapper

struct Model_Chapter: Mappable {

    init?(map: Map) {
    }
    mutating func mapping(map: Map) {

        ChapterID <- map["ChapterID"]
        GradeName <- map["GradeName"]
        GradeID <- map["GradeID"]
        Icon <- map["Icon"]
        OrderID <- map["OrderID"]
        Title <- map["Title"]
        SubjectID <- map["SubjectID"]
        
        Childs <- map["Childs"]
    }
    
    
    /// 班级id
    var GradeID = 0
    
    /// 班级名字
    var GradeName = ""
    
    /// 章节id
    var ChapterID = 0
    
    var Icon = ""
    
    var OrderID = 0
    
    var Title = ""
    
    var SubjectID = 0
    
    var Childs:[Model_Lesson] = []
    
    var isSelect = false
    
    
    
}

struct Model_Lesson : Mappable{
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        ChapterID <- map["ChapterID"]
        GradeName <- map["GradeName"]
        GradeID <- map["GradeID"]
        Icon <- map["Icon"]
        OrderID <- map["OrderID"]
        Title <- map["Title"]
        SubjectID <- map["SubjectID"]
        SubjectName <- map["SubjectName"]
    }
    


    
    
    /// 班级id
    var GradeID = 0
    
    /// 班级名字
    var GradeName = ""
    
    /// 章节id
    var ChapterID = 0
    
    var Icon = ""
    
    var OrderID = 0
    
    var Title = ""
    
    var SubjectID = 0
    
    var SubjectName = ""
    
    
    
}

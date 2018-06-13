//
//  Model_GradeSubject.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/15.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import ObjectMapper
struct Model_GradeSubject:Mappable{
    mutating func mapping(map: Map) {
        GradeID <- map["GradeID"]
        GradeName <- map["GradeName"]
        SubjectID <- map["SubjectID"]
        SubjectName <- map["SubjectName"]
        SchoolYearID <- map["SchoolYearID"]
        HomeworkList <- map["HomeworkList"]
    }
    init?(map: Map) {
        
    }
    var GradeID = 0
    var GradeName = ""
    var SubjectID = 0
    var SubjectName = ""
    var SchoolYearID = 0
    
    var HomeworkList:[Model_HomeWork]? = nil
}

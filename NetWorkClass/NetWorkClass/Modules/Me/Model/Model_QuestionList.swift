//
//  Model_QuestionList.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/12.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import ObjectMapper

struct Model_QuestionList: Mappable {

    mutating func mapping(map: Map) {
        AnswerID <- map["AnswerID"]
        CreateTime <- map["CreateTime"]
        Question <- map["Question"]
        Answers <- map["Answers"]
        StuName <- map["StuName"]
        QuestionImg <- map["QuestionImg"]
        AnswersImg <- map["AnswersImg"]
        IsRead <- map["IsRead"]
        StudentID <- map["StudentID"]

    }
    init?(map: Map) {
        
    }
    var AnswerID = 0
    var CreateTime = ""
    var Question = ""
    var Answers = ""
    var QuestionImg = ""
    var StuName = ""
    var AnswersImg = ""
    var IsRead = 0
    var StudentID = 0

}

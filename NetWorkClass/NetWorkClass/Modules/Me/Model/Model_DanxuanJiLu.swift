//
//  Model_DanxuanJiLu.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/11.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import ObjectMapper

struct Model_DanxuanJiLu: Mappable {

    mutating func mapping(map: Map) {
        //题目
        QuestionID <- map["question.QuestionID"]
        QuestionTypeID <- map["question.QuestionTypeID"]
        TypeName <- map["question.TypeName"]
        Stem <- map["question.Stem"]
        StemImg <- map["question.StemImg"]
        FixedType <- map["question.FixedType"]
        Analysis <- map["question.Analysis"]
        Score <- map["question.Score"]
        
        
        QuestionBody <- map["questionBody"]
        myQuestionBody <- map["myQuestionBody"]
        
        //我的选择
        QuestionBodyID <- map["myQuestionBody.QuestionBodyID"]
        ContentAddress <- map["myQuestionBody.ContentAddress"]
        //我回答题的ID
        ExamDetailsID <- map["myQuestionBody.ExamDetailsID"]
    }
    init?(map: Map) {
        
    }
    
    var QuestionID = 0
    var QuestionTypeID = 0
    var TypeName = ""
    var FixedType = ""
    /// 题干
    var Stem = ""
    /// 图片
    var StemImg = ""
    /// 解析
    var Analysis = ""
    /// 我的选择
    var MySelect:[Int] = []
    /// 得分
    var Score = 0
    
    
    //我的选择
    var QuestionBodyID = ""
    var ContentAddress = ""
    
    
    var QuestionBody:[Model_DanxuanBody] = []
    var myQuestionBody:Model_MySelectOption?
    var ExamDetailsID = 0
    
    
    
}


struct Model_DanxuanJiLuQuestion:Mappable {
    mutating func mapping(map: Map) {
        QuestionID <- map["QuestionID"]
        QuestionTypeID <- map["QuestionTypeID"]
        TypeName <- map["TypeName"]
        Stem <- map["Stem"]
        StemImg <- map["StemImg"]
        FixedType <- map["FixedType"]
        Analysis <- map["Analysis"]
        Score <- map["Score"]
        
    }
    init?(map: Map) {
        
    }
    var QuestionID = 0
    var QuestionTypeID = 0
    var TypeName = ""
    var FixedType = ""
    /// 题干
    var Stem = ""
    /// 图片
    var StemImg = ""
    /// 解析
    var Analysis = ""
    /// 我的选择
    var MySelect:[Int] = []
    /// 得分
    var Score = 0
    
}

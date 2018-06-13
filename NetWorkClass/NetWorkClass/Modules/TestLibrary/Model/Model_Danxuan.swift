//
//  Model_Danxuan.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/28.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import ObjectMapper

struct Model_DanxuanBody: Mappable {
    /**
     "QuestionBodyID": 5,
     "QuestionID": 3,
     "OptionKey": "1",
     "OptionValue": "1",
     "IsRight": 1
     */
    mutating func mapping(map: Map) {
        QuestionBodyID <- map["QuestionBodyID"]
        QuestionID <- map["QuestionID"]
        OptionKey <- map["OptionKey"]
        OptionValue <- map["OptionValue"]
        IsRight <- map["IsRight"]
    }
    init?(map: Map) {
        
    }
    var QuestionBodyID = 0
    var QuestionID = 0
    var OptionKey = ""
    var OptionValue = ""
    var IsRight = 0
    
}

struct Model_Danxuan : Mappable {
    /**
     "data": {
     "ExamBodyID": 3,
     "ExamID": 4,
     "QuestionID": 3,
     "QuestionTypeID": 2,
     "TypeName": "多选",
     "FixedType": "2",
     "Stem": "133QAQ%E7%BE%A4",
     "StemImg": "/UploadFiles/QuestionImg/image/20171120/20171120103918_4467_small.png",
     "QuestionStageID": 1,
     "Score": 1,
     "TeacherID": 12,
     "TeacherName": null,
     "Analysis": "1",
     "AnalysisImg": "/UploadFiles/QuestionImg/image/20171120/20171120103916_7463_small.png",
     "GradeID": 7,
     "GradeName": "小学四年级",
     "SubjectID": 2,
     "SubjectName": "语文",
     "QuestionBody": [
     {
     "QuestionBodyID": 5,
     "QuestionID": 3,
     "OptionKey": "1",
     "OptionValue": "1",
     "IsRight": 1
     }
     ]
     ExamDetails =     (
     {
     ContentAddress = "[]";
     CreateDateTime = "2017-12-08T16:32:11.477";
     ExamBodyID = 6;
     ExamDetailsID = 203;
     IsFinish = 0;
     QuestionBodyID = 1436;
     Score = 2;
     StudentID = 25;
     }
     );
     }
     */
    mutating func mapping(map: Map) {
        
        ExamBodyID <- map["ExamBodyID"]
        ExamID <- map["ExamID"]
        QuestionID <- map["QuestionID"]
        QuestionTypeID <- map["QuestionTypeID"]
        TypeName <- map["TypeName"]
        QuestionBody <- map["QuestionBody"]
        Stem <- map["Stem"]
        StemImg <- map["StemImg"]
        FixedType <- map["FixedType"]
        Analysis <- map["Analysis"]
        Score <- map["Score"]
        ExamDetails <- map["ExamDetails"]
        HomeworkBodyID <- map["HomeworkBodyID"]
    }
    
    init?(map: Map) {
        
    }
    var ExamBodyID = 0
    var ExamID = 0
    var QuestionID = 0
    var QuestionTypeID = 0
    var TypeName = ""
    /// 选项
    var QuestionBody:[Model_DanxuanBody] = []
    
    /// 我的选择的答案
    var ExamDetails:[Model_MySelectOption] = []
    
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
    var HomeworkBodyID = 0
    
}

/// 我选择的答案
/**
 ExamDetails =     (
 {
 ContentAddress = "[]";
 CreateDateTime = "2017-12-08T16:32:11.477";
 ExamBodyID = 6;
 ExamDetailsID = 203;
 IsFinish = 0;
 QuestionBodyID = 1436;
 Score = 2;
 StudentID = 25;
 }
 );
 */
struct Model_MySelectOption:Mappable {
    mutating func mapping(map: Map) {
        ContentAddress <- map["ContentAddress"]
        CreateDateTime <- map["CreateDateTime"]
        ExamBodyID <- map["ExamBodyID"]
        ExamDetailsID <- map["ExamDetailsID"]
        IsFinish <- map["IsFinish"]
        QuestionBodyID <- map["QuestionBodyID"]
        Score <- map["Score"]
        StudentID <- map["StudentID"]
    }
    init?(map: Map) {
        
    }
    var ContentAddress = ""
    var CreateDateTime = ""
    var ExamBodyID = 0
    var ExamDetailsID = 0
    var IsFinish = 0
    var QuestionBodyID = ""
    var Score = 0
    var StudentID = 0
}









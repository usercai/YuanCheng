//
//  UserInfo.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/18.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import ObjectMapper
import RxSwift

class UserInfo:NSObject {

    
    static let shareInstance = UserInfo()
    private override init() {
    }
    
    var UserRole:UserRole = .Student
    var Key = ""
    
    var user : User = User(JSON: ["GradeID" : 0])!
    var student:Student = Student(JSON: ["StudentID":0])!
    var teacher:Teacher = Teacher(JSON: ["TeacherID":0])!
    ///用户头像
    var userpic:Variable<String> = Variable<String>("")
    
    func UserID()->Int {
        if KUserInfo.UserRole == .Student {
            return user.StudentID
        }else{
            return user.TeacherID
        }
    }
    func UserName() -> String {
        if KUserInfo.UserRole == .Student {
            return user.StuName
        }else{
            return user.TeacherName
        }
    }
    func MobilePhone() -> String {
        if KUserInfo.UserRole == .Student{
            return KUserInfo.student.StuNumber
        }else{
            return KUserInfo.teacher.MobilePhone
        }
    }
    
}

struct Teacher:Mappable {
    
    mutating func mapping(map: Map) {
        MobilePhone <- map["MobilePhone"]
    }
    init?(map: Map) {
        
    }

    var GradeList:[Model_Grade] = []
    var SubList:[Model_Subject] = []
    var MobilePhone = ""
}

struct User:Mappable {
    
    mutating func mapping(map: Map) {
        
        StudentID <- map["StudentID"]
        StuName <- map["StuName"]
        Year <- map["StuName"]
        Mood <- map["StuName"]
        GradeID <- map["GradeID"]
        GradeName <- map["GradeName"]
        ClassesName <- map["ClassesName"]
        Picture <- map["Picture"]
        MobilePhone <- map["MobilePhone"]
        TeacherID <- map["TeacherID"]
        TeacherName <- map["TeacherName"]
    }
    
    init?(map: Map) {

    }
    
    var TeacherName = ""
    var TeacherID = 0
    var StudentID = 0
    var StuName = ""
    var Year = 0
    var Mood = ""
    var GradeID = 0
    var GradeName = ""
    var ClassesName = ""
    var Picture = ""
    var MobilePhone = ""
    
    
}

struct Student : Mappable{
    
    mutating func mapping(map: Map) {
        StudentID <- map["StudentID"]
        Birthday <- map["Birthday"]
        StuName <- map["StuName"]
        MobilePhone <- map["MobilePhone"]
        GradeName <- map["GradeName"]
        StuNumber <- map["StuNumber"]
    }
    init?(map: Map) {
        
    }
    var StudentID = 0
    var StuName = ""
    var Birthday = ""
    var GradeName = ""
    var MobilePhone = ""
    var StuNumber = ""
}




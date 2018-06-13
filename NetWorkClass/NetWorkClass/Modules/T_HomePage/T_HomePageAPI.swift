//
//  T_HomePageAPI.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/20.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

import Moya

enum T_HomePageAPI {

    //根据日期获取本日有作业的科目(老师)
    case QueryTeaSubjectData(String)
    case AssignHomework(Int,Int,Int,String,String,String,String)
}

extension T_HomePageAPI:TargetType{
    
    var baseURL: URL{
        return URL.init(fileURLWithPath: BaseURL)
    }
    
    var path: String{
        switch self {
        case .QueryTeaSubjectData(_):
            return "api/HomeWork/QueryTeaSubjectData"
        case .AssignHomework(_,_, _, _, _, _, _):
            return "api/HomeWork/AssignHomework"
        default:
            return ""
        }
    }
    
    var method: Moya.Method{
        return .post
    }
    
    var sampleData: Data{
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task{
        var DataArray:[String:Any] = ["Key":KUserInfo.Key]
        switch self {
        case .QueryTeaSubjectData(let seldate):
            DataArray["seldate"] = seldate
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .AssignHomework( let homeworkid,let schoolyearid, let subjectid, let jsonHomeworkFiles, let homeworkdate, let homeworktitle, let homeworkimg):
            DataArray["schoolyearid"] = schoolyearid.string()
            DataArray["subjectid"] = subjectid.string()
            DataArray["jsonHomeworkFiles"] = jsonHomeworkFiles
            DataArray["homeworkdate"] = homeworkdate
            DataArray["homeworktitle"] = homeworktitle
            DataArray["homeworkimg"] = homeworkimg
            DataArray["homeworkid"] = homeworkid
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        
        default:
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        }
        
    }
    
    var headers: [String : String]?{
        return [:]
    }
    
}

let T_HomePageTool = MoyaProvider<T_HomePageAPI>()


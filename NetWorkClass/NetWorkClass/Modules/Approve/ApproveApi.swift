//
//  ApproveApi.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/14.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import Moya

enum ApproveApi {
/// 根据年月日 获取老师的年级和学科 seldate(日期：年月日 是要查询的)。返回值:(msgCode 1-获取成功 2-未登录)
    case QuerySubject(String)
/// - 获取当月审核列表
    case QueryDayData(String)
/// - 根据登录老师、年级、科目 获取 未批改的作业列表 参数：pageIndex(页码 int)，pageSize（每页条数 int）gradeid（年级ID）subjectid（科目ID）datetime（日期：2017-12-15）
    case QueryExaminHomeworkList(Int,Int,Int,Int,String)
/// - 根据登录老师获取 提问列表参数：pageIndex(页码 int)，pageSize（每页条数 int）
    case QueryExaminAnswerList(Int,Int)
/// - 根据登录老师获取 试卷列表参数：pageIndex(页码 int)，pageSize（每页条数 int）gradeid（年级ID）subjectid（科目ID）
    case QueryExaminList(Int,Int,Int,Int)
/// - 老师回答提问 参数：answerid（学生提问的ID），answers(回答)，answersimg(回答图片))
    case ReviewAnswerData(Int,String,String)
/// api/Examin/ReviewHomeworkData 参数：homeworkid（学生提问的ID），isfinish(是否审阅：0未审核 1审核通过 2审核拒绝)
    case ReviewHomeworkData(Int,Int,String)
/// 获取老师未批改试卷的年级和学科
    case QueryExaminSubject()
/// 根据试卷id获取试卷题目列表(模拟卷)  index(第几题) examID（试卷id int) StudentID（学生ID
    case QueryExaminBodyList(Int,Int,Int)
/// 老师审阅考生考试题目 examdetailsid（试卷题目的ID），score(分数)，isfinish(是否审阅))
    case ReviewDetailesData(Int,Int,Int)
    
}

extension ApproveApi:TargetType{

    var baseURL: URL{
        return URL.init(fileURLWithPath: BaseURL)
    }
    
    var path: String{
        switch self {
        case .QuerySubject(_):
            return "api/Examin/QuerySubject"
        case .QueryDayData(_):
            return "api/Examin/QueryDayData"
        case .QueryExaminHomeworkList(_, _, _, _, _):
            return "api/Examin/QueryExaminHomeworkList"
        case .QueryExaminAnswerList(_, _):
            return "api/Examin/QueryExaminAnswerList"
        case .QueryExaminList(_, _, _, _):
            return "api/Examin/QueryExaminList"
        case .ReviewAnswerData(_, _, _):
            return "api/Examin/ReviewAnswerData"
        case .ReviewHomeworkData(_,_,_):
            return "api/Examin/ReviewHomeworkData"
        case .QueryExaminSubject():
            return "api/Examin/QueryExaminSubject"
        case .QueryExaminBodyList(_, _, _):
            return "api/Examin/QueryExaminBodyList"
        case .ReviewDetailesData(_, _, _):
            return "api/Examin/ReviewDetailesData"
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
        case .QuerySubject(let seldate):
            DataArray["seldate"] = seldate
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QueryDayData(let seldate):
            DataArray["seldate"] = seldate
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QueryExaminHomeworkList(let pageIndex, let pageSize, let gradeid, let subjectid, let datetime):
            DataArray["pageIndex"] = pageIndex.string()
            DataArray["pageSize"] = pageSize.string()
            DataArray["gradeid"] = gradeid.string()
            DataArray["subjectid"] = subjectid.string()
            DataArray["datetime"] = datetime
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QueryExaminAnswerList(let pageIndex, let pageSize):
            DataArray["pageSize"] = pageSize.string()
            DataArray["pageIndex"] = pageIndex.string()
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QueryExaminList(let pageIndex, let pageSize, let gradeid, let subjectid):
            DataArray["pageIndex"] = pageIndex.string()
            DataArray["pageSize"] = pageSize.string()
            DataArray["gradeid"] = gradeid.string()
            DataArray["subjectid"] = subjectid.string()
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .ReviewAnswerData(let answerid, let answer, let answersimg):
            DataArray["answerid"] = answerid.string()
            DataArray["answers"] = answer
            DataArray["answersimg"] = answersimg
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .ReviewHomeworkData(let homeworkbodyid, let isfinish, let comment):
            DataArray["comment"] = comment
            DataArray["homeworkbodyid"] = homeworkbodyid.string()
            DataArray["isfinish"] = isfinish.string()
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QueryExaminSubject():

            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QueryExaminBodyList(let index, let examID, let StudentID):
            DataArray["StudentID"] = StudentID.string()
            DataArray["examID"] = examID.string()
            DataArray["index"] = index.string()
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .ReviewDetailesData(let examdetailsid, let score, let isfinish):
            DataArray["examdetailsid"] = examdetailsid.string()
            DataArray["score"] = score.string()
            DataArray["isfinish"] = isfinish.string()
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
         default:
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        }
        
    }
    
    var headers: [String : String]?{
        return [:]
    }

}

let ApproveTool = MoyaProvider<ApproveApi>()

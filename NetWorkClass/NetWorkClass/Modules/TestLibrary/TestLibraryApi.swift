//
//  TestLibraryApi.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/25.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import Moya

enum TestLibraryApi {
    
// MARK: - 根据年级获取学科列表(练习题)
    case QuestionSubjectList(Int)
// MARK: - 根据年级获取学科试卷列表(模拟卷)
    case ExamSubjectList(Int)
// MARK: - 根据年级和科目获取学科试卷列表(模拟卷)
    case ExamList(Int,Int)
// MARK: - 根据科目id获取题目类型列表(练习题)
    case QuestionTypeList(Int,Int)
// MARK: - 根据题目类型id获取题目列表(练习题) 参数：typeID（题目类型id int）,pageIndex(页码 int)，pageSize（每页条数 int）sId（科目id int）gId（年级id int）返回值msgCode：1（成功），2（参数错误），3（数据为空），
    case QuestionList(Int,Int,Int,Int,Int)
// MARK: - 根据试卷id获取试卷题目列表(模拟卷) examID（试卷id int),index(第几题 int)
    case ExamBodyList(Int,Int)
     
// MARK:学生提交考试题目（没做的新增，做过的先删除在新增） - 参数：exambodyid（试卷题目的ID），questionbodyid（没做的传0，做过的传 questionbodyid 过来,多选逗号拼接），contentaddress（非选择题图片地址）,score(选择题分数，非选择题0，studentid(考生id))。返回值：msgCode-1提交成功,2参数不足,3提交失败,4删除失败
    case SubmitDetailesData(Int,String,String,Int,Int)
/// 学生交卷参数：examid（试卷的ID），studentid(考生id))
     case SubmitAllQuestion(Int,Int)
    
}

extension TestLibraryApi:TargetType{
    
    var baseURL: URL {
        return BaseURL.url()
    }
    
    var path: String {
        switch self {
        case .QuestionSubjectList(_):
            
            return "api/Question/QuestionSubjectList"
        case .ExamSubjectList(_):
            return "api/Question/ExamSubjectList"
        case .ExamList(_, _):
            return "api/Question/ExamList"
        case .QuestionTypeList(_):
            return "api/Question/QuestionTypeList"
        case .QuestionList(_):
            return "api/Question/QuestionList"
        case .ExamBodyList(_, _):
            return "api/Question/ExamBodyList"
        case .SubmitDetailesData(_):
            return "api/Question/SubmitDetailesData"
        case .SubmitAllQuestion(_, _):
          return "api/Question/SubmitAllQuestion"
        default:
            return "api/Question/QuestionSubjectList"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
        
    }
    
    var task: Task {
        var DataArray:[String:String] = ["Key":KUserInfo.Key]
        switch self {
        case .QuestionSubjectList(let gId):
            DataArray["gId"] = gId.string()

            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QuestionList(let typeID, let pageIndex, let pageSize, let sId, let gId):
            DataArray["typeID"] = typeID.string()
            DataArray["pageIndex"] = pageIndex.string()
            DataArray["pageSize"] = pageSize.string()
            DataArray["sId"] = sId.string()
            DataArray["gId"] = gId.string()
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QuestionTypeList(let sId,let gId):
            DataArray["sId"] = sId.string()
            DataArray["gId"] = gId.string()
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .ExamList(let gId, let sId):
            DataArray["gId"] = gId.string()
            DataArray["sId"] = sId.string()
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .ExamSubjectList(let gId):
            DataArray["gId"] = gId.string()
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .ExamBodyList(let examID, let index):
            DataArray["examID"] = examID.string()
            DataArray["index"] = index.string()
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .SubmitDetailesData(let exambodyid, let questionbodyid, let contentaddress, let score, let studentid):
            DataArray["exambodyid"] = exambodyid.string()
            DataArray["questionbodyid"] = questionbodyid
            DataArray["contentaddress"] = contentaddress
            DataArray["score"] = score.string()
            DataArray["studentid"] = studentid.string()
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .SubmitAllQuestion(let examid, let studentid):
          DataArray["examid"] = examid.string()
          DataArray["studentid"] = studentid.string()
          return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)

        default:
            
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
}

let TestLibraryTool = MoyaProvider<TestLibraryApi>()


//
//  LoginAndRegisterApi.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/21.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import Moya

enum LoginAndRegisterApi {
    
    ///登陆 username password type
    case UserLogin(String,String,String)
// MARK: - 获取验证码 VerificationPhone手机号，countryCode国家码
    case VerificationCode(String,String)
// MARK: - 修改密码   password，VerificationPhone，verificationCode，type(int)0-学生 1-老师
    case UpdatePassWord(String,String,String,String)


}

extension LoginAndRegisterApi:TargetType{
    var baseURL: URL {
        
        return URL(fileURLWithPath: BaseURL)
    }
    
    var path: String {
        switch self {
        case .UserLogin(_, _, _):
            
            return "api/Login/UserLogin"

        case .VerificationCode(_, _):
            return "api/Login/QueryVerificationCode"
        case .UpdatePassWord(_, _, _, _):
            return "api/Login/UpdatePassWord"


        default:
            return "api/Login/UserLogin"
        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!

    }
    
    var task: Task {
        var DataArray:[String:String] = ["Key":KUserInfo.Key]

        switch self {
        case .UserLogin(let username, let password, let type):
            DataArray["username"] = username
            DataArray["password"] = password
            DataArray["type"] = type
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)


        case .VerificationCode(let VerificationPhone, let countryCode):
            DataArray["VerificationPhone"] = VerificationPhone
            DataArray["countryCode"] = countryCode
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .UpdatePassWord(let password, let VerificationPhone, let verificationCode, let type):
            DataArray["password"] = password
            DataArray["VerificationPhone"] = VerificationPhone
            DataArray["verificationCode"] = verificationCode
            DataArray["type"] = type
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)

        
        default:

            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
            return [:]
    }
    
    /// 参数
    var parameters: [String: Any]? {
        
        var DataArray = ["":""]
        switch self {
        case .UserLogin(let username, let password, let type):
            DataArray["username"] = username
            DataArray["password"] = password
            DataArray["type"] = type
            return DataArray
        default:
            return [:]
        }
        
    }
    
    
    
    
}

let LoginAndRegisterTool = MoyaProvider<LoginAndRegisterApi>()


//
//  BaseApiManager.swift
//  SwiftFrame
//
//  Created by mac on 2017/11/17.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import Moya


struct Parameter {

    var Api : String = ""
    var DataSource = ["":""]

}

enum BaseNetWorkTool {
    
    case data(Api:Parameter)
}

extension BaseNetWorkTool:TargetType{
    
    
    /// 请求头
    var headers: [String : String]? {
        return [:]
    }
    /// URL通用的部分
    var baseURL: URL {
        
        return URL(string: "")!
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .data(Api: let parameter):
            return parameter.Api
        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        return .get
    }
    
    /// 参数
    var parameters: [String: Any]? {
        switch self {
        case .data(Api: let parameter):
            return parameter.DataSource
        default:
            return [:]
        }
        
    }
    
    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    /// Provides stub data for use in testing.
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    /// The type of HTTP task to be performed.
    var task: Task {
        return .requestPlain
    }
    
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool {
        return false
    }
}

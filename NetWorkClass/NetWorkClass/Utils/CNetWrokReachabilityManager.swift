//
//  CNetWrokReachabilityManager.swift
//  NetWorkClass
//
//  Created by mac on 2018/1/2.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa

enum NetWorkType {
    case WIFI
    case wwan
    case Nowork
    
}
class CNetWrokReachabilityManager: NSObject {

    static let share = CNetWrokReachabilityManager()
    public var status:Variable<NetWorkType> = Variable<NetWorkType>(.wwan)
    private var manager:NetworkReachabilityManager?
    private override init() {
        super.init()
        self.manager = NetworkReachabilityManager(host: "www.apple.com")
        
        self.manager?.listener = { status in
            
            switch status {
            case .notReachable:
                self.status.value = .Nowork
            case .reachable(.ethernetOrWiFi):
                self.status.value = .WIFI
            case .reachable(.wwan):
                self.status.value = .wwan
            default:
                self.status.value = .Nowork
            }
            
        }
        
    }
    func startListen() {
        self.manager?.startListening()
    }
    
}

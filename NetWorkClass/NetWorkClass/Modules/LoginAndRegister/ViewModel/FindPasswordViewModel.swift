//
//  FindPasswordViewModel.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/9.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FindPasswordViewModel: BaseViewModel {

    
    
    
    //获取验证码
    func getDataList(phone:String,contrycode:String) {

        LoginAndRegisterTool.rx.request(LoginAndRegisterApi.VerificationCode(phone, contrycode)).asObservable().subscribe(onNext: { (response) in
            
            response.C_mapjson(success: { (dic) in

                CProgressHUD.showText(text: "获取成功")
                
            }, falue: { (code, msg) in
                CProgressHUD.showText(text: "获取失败")
            })
        }, onError: { (error) in
            CProgressHUD.showText(text: "请求失败")

        }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        

    }
    

    
    let models = Variable<Bool>(false)
    
    
    
    typealias output = OutPut
    
    struct OutPut {
        let models : Driver<Bool>
        let requestCommond = PublishSubject<Bool>()
        let refreshStatus = Variable<RefreshStatus>(.none)
        
        init(models:Driver<Bool>) {
            self.models = models
        }
    }
    func getDataList(password:String,VerificationPhone:String,verificationCode:String) -> output{
        
        let models = self.models.asObservable().map { (models) -> Bool in
            return models
            }.asDriver(onErrorJustReturn: false)
        
        let output = OutPut.init(models: models)
        output.requestCommond.subscribe(onNext: { (isReload) in
            let role = KUserInfo.UserRole == .Student ? "0" : "1"
            
            
            LoginAndRegisterTool.rx.request(LoginAndRegisterApi.UpdatePassWord(password, VerificationPhone, verificationCode, role)).asObservable().subscribe(onNext: { (response) in
                response.C_mapjson(success: { (dic) in

                    self.models.value = true
                }, falue: { (code, error) in
                    self.models.value = false
                })
            }, onError: { (error) in
                self.models.value = false
            }, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)

        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        
        return output
    }
    
}

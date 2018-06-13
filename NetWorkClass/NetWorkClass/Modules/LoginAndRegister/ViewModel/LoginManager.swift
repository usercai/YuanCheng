//
//  LoginManager.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/21.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import RxCocoa
import ObjectMapper
import PushKit
import Alamofire

struct LoginOutput {
    
    var sections : Driver<Bool>
    // 外界通过该属性告诉viewModel加载数据（传入的值是为了标志是否重新加载）
    let requestCommond = PublishSubject<Bool>()
    
    init(section:Driver<Bool>) {
        
        self.sections = section
    }
    
}

class LoginManager: NSObject {

    let dis = DisposeBag()
    
    let LoginResults = Variable<Bool>(false)
    

    
    func Login(username:String,password:String,type:UserRole){
        
        let typestr = type == .Student ? "0":"1"
        KUserInfo.UserRole = type
        
        self.LoginResults.asObservable().skipWhile{$0 == true}.subscribe(onNext: { (isSuccess) in
            if KUserInfo.Key != ""{
                self.getuserInfo()
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: dis)
        
        
        CProgressHUD.showLoading()
        LoginAndRegisterTool.rx.request(LoginAndRegisterApi.UserLogin(username, password.md5(), typestr)).subscribe(onSuccess: { (response) in
            response.C_mapjson(success: { (dict) in
                
                KUserInfo.Key = dict["Key"] as! String
                KUserInfo.user = Mapper<User>().map(JSON: dict["user"] as! [String : Any])!

                KUserInfo.userpic.value = KUserInfo.user.Picture

                //保存密码
                KeyChainTool.saveUserAccount(userAccount: username, Password: password, UserType: UserInfo.shareInstance.UserRole, LoginType: "1")

                self.LoginResults.value = true
                
            }, falue: { (code, msg) in
                
                CProgressHUD.showError(error: msg)
                self.LoginResults.value = false
            })
            
            CProgressHUD.hiddenLoading()
        }) { (error) in
            self.LoginResults.value = false
            CProgressHUD.hiddenLoading()
        }.disposed(by: dis)

        
        
        
    }
    
    func getuserInfo() {
        
        MeTool.rx.request(MeApi.QueryUserInfo()).asObservable().subscribe(onNext: { (response) in
            
            response.C_mapjson(success: { (dict) in
                
                if KUserInfo.UserRole == .Student{
                    KUserInfo.student = Mapper<Student>().map(JSON: dict)!

                }else{
                    KUserInfo.teacher = Mapper<Teacher>().map(JSON: dict)!
                }
                
                if KUserInfo.MobilePhone() != ""{
                    self.addPushSetting()
                }

            }, falue: { (code, msg) in
                print(msg)
            })
        }, onError: { (error) in
            
            print(error)
        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)
        

    }
    
    
    func addPushSetting(){
        JPUSHService.setAlias(KUserInfo.MobilePhone(), completion: { (code, alias, isalias) in

        }, seq: 1)
        

        
    }
    
    func getTeacherGrade(){
        MeTool.rx.request(MeApi.QuerySubject()).asObservable().subscribe(onNext: { (response) in
            response.C_mapjson(success: { (dic) in
                
            }, falue: { (code, msg) in
                
            })
        }, onError: { (error) in
            
        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)
    }
    
    
}


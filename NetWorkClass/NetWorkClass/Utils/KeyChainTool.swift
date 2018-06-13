//
//  KeyChainTool.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/23.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit



class KeyChainTool: NSObject {


    
    
    class func saveUserAccount(userAccount:String,Password:String,UserType:UserRole,LoginType:String){
        

        let usertype = UserType == .Student ? "0" : "1"
        saveKeyChain(key: KEY_USERACCOUNT, value: userAccount)
        saveKeyChain(key: KEY_PASSWORD , value: Password)
        saveKeyChain(key: KEY_LOGINTYPE , value: LoginType)
        saveKeyChain(key: KEY_USERTYPE , value: usertype)
        
        print(getRole())
        
    }
    
    class fileprivate func saveKeyChain(key:String,value:String) {
//        if KeychainWrapper.standard.string(forKey: key) == nil || KeychainWrapper.standard.string(forKey: key) == "" {
        
        KeychainWrapper.standard.set(value, forKey: key)

        //        }
    }
    
    class func deletePassWordChain() {
        
        KeychainWrapper.standard.removeObject(forKey: KEY_PASSWORD)
    }
    
    class func getPassWord() -> String{
    
        return KeychainWrapper.standard.string(forKey: KEY_PASSWORD) ?? ""
    }
    class func getUserAccount() -> String{
        return KeychainWrapper.standard.string(forKey: KEY_USERACCOUNT) ?? ""
    }
    class func getRole() -> UserRole{
        return KeychainWrapper.standard.string(forKey: KEY_USERTYPE) == "0" ? .Student : .Teacher
    }
    
}

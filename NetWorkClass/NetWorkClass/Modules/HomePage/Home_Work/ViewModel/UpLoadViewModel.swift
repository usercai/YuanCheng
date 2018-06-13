//
//  UpLoadViewModel.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/2.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


enum FileAddress:String {
    
    case HomeworkImg = "HomeworkImg"
    
    
}

class UpLoadViewModel: BaseViewModel {

    let models = Variable<[Model_Path]>([])
    
    
    
    typealias output = OutPut
    
    struct OutPut {
        let models : Driver<[Model_Path]>
        let requestCommond = PublishSubject<Bool>()
        let refreshStatus = Variable<RefreshStatus>(.none)
        
        init(models:Driver<[Model_Path]>) {
            self.models = models
        }
    }

    
    func uploadImage(fileArr:[UIImage],name:String,fileAddress:FileAddress) -> output {

        CProgressHUD.showLoading()
        let models = self.models.asObservable().map { (models) -> [Model_Path] in
            return models
            }.asDriver(onErrorJustReturn: [])
        
        let output = OutPut.init(models: models)
        var arr : [Model_Path] = []
        for (index, image) in fileArr.enumerated(){
            
            
            homePageTool.rx.request(HomePageApi.Upload(image.base64().utf8encodedString(), name, fileAddress.rawValue)).asObservable().mapArray(Model_Path.self).subscribe(onNext: { (models) in
                if models.count != 0{
                    arr.append(models.first!)
                }
                if index == fileArr.count - 1{
                    
                    self.models.value = arr
                    CProgressHUD.hiddenLoading()
                }
                
            }, onError: { (error) in
                
                CProgressHUD.hiddenLoading()
                
            }, onCompleted: {
                
            }) {
                
                }.disposed(by: self.disposeBag)
            
            
        }
        
        return output
    }
    
    func upLoad(fileArr:[String],name:String,fileAddress:FileAddress) -> output {

        CProgressHUD.showLoading()
        let models = self.models.asObservable().map { (models) -> [Model_Path] in
            return models
            }.asDriver(onErrorJustReturn: [])
        
        let output = OutPut.init(models: models)
        var arr : [Model_Path] = []
        for (index, _) in fileArr.enumerated(){
            homePageTool.rx.request(HomePageApi.Upload(fileArr[index], name, fileAddress.rawValue)).asObservable().mapArray(Model_Path.self).subscribe(onNext: { (models) in
                if models.count != 0{
                    arr.append(models.first!)
                }
                if index == fileArr.count - 1{
                    
                    self.models.value = arr
                    CProgressHUD.hiddenLoading()
                }
                
            }, onError: { (error) in
                
                CProgressHUD.hiddenLoading()

            }, onCompleted: {
                
            }) {
                
                }.disposed(by: self.disposeBag)
            

        }
        
        return output
    }
}

//
//  ViewModel_UpdateStuGrade.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/28.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewModel_UpdateStuGrade: BaseViewModel {

    let models = Variable<Bool>(true)
    
    
    
    typealias output = OutPut
    
    struct OutPut {
        let models : Driver<Bool>
        let requestCommond = PublishSubject<Bool>()
        let refreshStatus = Variable<RefreshStatus>(.none)
        
        init(models:Driver<Bool>) {
            self.models = models
        }
    }
    func getDataList(classesid:Int) -> output{
        
        let models = self.models.asObservable().map { (issuccess) -> Bool in
            return issuccess
        }.asDriver(onErrorJustReturn: false)

        let out = OutPut(models: models)
        
        homePageTool.rx.request(HomePageApi.UpdateStuGrade(classesid)).subscribe(onSuccess: { (response) in
            response.C_mapjson(success: { (dict) in

                self.models.value = true
            }, falue: { (code, msg) in
                self.models.value = false
            })
        }) { (error) in
            
            
        }.disposed(by: disposeBag)

        return out
    }
    
}

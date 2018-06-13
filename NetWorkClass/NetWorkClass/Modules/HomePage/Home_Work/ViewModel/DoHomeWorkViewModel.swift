//
//  DoHomeWorkViewModel.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/2.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper
class DoHomeWorkViewModel: BaseViewModel {

    

    func getDataList(homeworkid:Int,homeworkbodyid:Int,jsonHomeworkFiles:String) -> Observable<Bool>{
        
        homePageTool.rx.request(HomePageApi.SubmitData(homeworkid, homeworkbodyid, jsonHomeworkFiles)).subscribe(onSuccess: { (response) in
            
            response.C_mapjson(success: { (dic) in
                
                return Observable.just(true)
            }, falue: { (code, error) in
                
                return Observable.just(false)
            })
        }) { (error) in
            
            return Observable.just(false)
        }.disposed(by: disposeBag)

        return Observable.just(false)
    }
    
}

//
//  TL_TestPaperInfoViewModel.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/28.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TL_TestPaperInfoViewModel: BaseViewModel {

    let models = Variable<[Model_Danxuan]>([])
    
    
    
    typealias output = OutPut
    enum swip {
        case next
        case last
        case first
    }
    struct OutPut {
        let models : Driver<[Model_Danxuan]>
        let requestCommond = PublishSubject<swip>()
        let refreshStatus = Variable<RefreshStatus>(.none)
        
        init(models:Driver<[Model_Danxuan]>) {
            self.models = models
        }
    }
    func getDataList(examID:Int,index:Int) -> output{
        
        let models = self.models.asObservable().map { (models) -> [Model_Danxuan] in
            return models
            }.asDriver(onErrorJustReturn: [])
        
        let output = OutPut.init(models: models)
        output.requestCommond.subscribe(onNext: { (isReload) in

            TestLibraryTool.rx.request(TestLibraryApi.ExamBodyList(examID, index + 1)).asObservable().mapArray(Model_Danxuan.self).subscribe(onNext: { (models) in
               

                self.models.value = models
                
            }, onError: { (error) in
                

            }, onCompleted: {
                
            }) {
                
                }.disposed(by: self.disposeBag)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        

        
        
        return output
    }
    
}

//
//  Home_NoticeInfoViewModel.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/11.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Home_NoticeInfoViewModel: BaseViewModel {

    let models = Variable<[Model_HomeView]>([])
    
    
    
    typealias output = OutPut
    
    struct OutPut {
        let models : Driver<[Model_HomeView]>
        let requestCommond = PublishSubject<Bool>()
        let refreshStatus = Variable<RefreshStatus>(.none)
        
        init(models:Driver<[Model_HomeView]>) {
            self.models = models
        }
    }
    func getDataList(noticeId:Int) -> output{
        
        let models = self.models.asObservable().map { (models) -> [Model_HomeView] in
            return models
            }.asDriver(onErrorJustReturn: [])
        
        let output = OutPut.init(models: models)
        output.requestCommond.subscribe(onNext: { (isReload) in

            homePageTool.rx.request(HomePageApi.QueryNotice(noticeId)).asObservable().mapArray(Model_HomeView.self).subscribe(onNext: { (models) in

                self.models.value = models
                
            }, onError: { (error) in
                
                output.refreshStatus.value = isReload ? RefreshStatus.endHeaderRefresh : .endFooterRefresh
                
            }, onCompleted: {
                output.refreshStatus.value = isReload ? RefreshStatus.endHeaderRefresh : .endFooterRefresh
                
            }) {
                
                }.disposed(by: self.disposeBag)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        
        return output
    }
    
}

//
//  Home_NotificationViewModel.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/24.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper

class Home_NotificationViewModel: BaseViewModel {

    let models = Variable<[Model_HomeView]>([])
    
    
    
    typealias output = Home_NoticeOutPut
    
    struct Home_NoticeOutPut {
        let models : Driver<[Model_HomeView]>
        let requestCommond = PublishSubject<Bool>()
        let refreshStatus = Variable<RefreshStatus>(.none)
        
        init(models:Driver<[Model_HomeView]>) {
            self.models = models
        }
    }
    func getNoticeList() -> output{
        
        let models = self.models.asObservable().map { (models) -> [Model_HomeView] in
            return models
        }.asDriver(onErrorJustReturn: [])
        
        let output = Home_NoticeOutPut.init(models: models)
        output.requestCommond.subscribe(onNext: { (isReload) in
            self.index = isReload ? 1 : self.index + 1
            homePageTool.rx.request(HomePageApi.QueryNoticeList(self.index, 10)).asObservable().mapArray(Model_HomeView.self).subscribe(onNext: { (models) in
                if models.count == 0 && isReload == false{
                    output.refreshStatus.value = RefreshStatus.noMoreData
                }
                self.models.value = isReload ? models : self.models.value + models
                
            }, onError: { (error) in
//                CProgressHUD.showError(error: error.localizedDescription)
                output.refreshStatus.value = isReload ? RefreshStatus.endHeaderRefresh : .endFooterRefresh

            }, onCompleted: {
                output.refreshStatus.value = isReload ? RefreshStatus.endHeaderRefresh : .endFooterRefresh

            }) {
                
                }.disposed(by: self.disposeBag)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        

        return output
    }
    
}



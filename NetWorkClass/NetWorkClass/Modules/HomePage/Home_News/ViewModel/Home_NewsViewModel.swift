//
//  Home_NewsViewModel.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/23.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import ObjectMapper
import RxCocoa

class Home_NewsViewModel: NSObject {

    let dis = DisposeBag()
    
    // 存放着解析完成的模型数组
    let models = Variable<[Model_HomeView]>([])
    // 记录当前的索引值
    var index: Int = 1
}

extension Home_NewsViewModel: BaseViewModelType {
    
    
    
    func transform(input: Home_NewsViewModel.ViewModelInput) -> Home_NewsViewModel.ViewModelOutput {
        
        let sections = models.asObservable().map { (models) -> [Section_HomeView] in
            return [Section_HomeView(items: models)]
        }.asDriver(onErrorJustReturn: [])
        
        let output = ViewModelOutput(sections: sections)
        
        output.requestCommond.subscribe(onNext: { (isReloadData) in
            self.index = isReloadData ? 1 : self.index + 1
            let isCycle = input.isCycleView==true ? 1 : 0
            homePageTool.rx.request(HomePageApi.QueryInfoList(isCycle, self.index, 10)).asObservable().mapArray(Model_HomeView.self).subscribe(onNext: { (modelArr) in
                if modelArr.count == 0 && isReloadData == false{
                    output.refreshStatus.value = RefreshStatus.noMoreData
                }
                self.models.value = isReloadData ? modelArr : (self.models.value) + modelArr
            }, onError: { (error) in
//                CProgressHUD.showError(error: error.localizedDescription)
                output.refreshStatus.value = isReloadData ? RefreshStatus.endHeaderRefresh : .endFooterRefresh
            }, onCompleted: {
                output.refreshStatus.value = isReloadData ? RefreshStatus.endHeaderRefresh : .endFooterRefresh
            }, onDisposed: nil).disposed(by: self.dis)
            
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: dis)
        
        return output
    }

    typealias Input = ViewModelInput
    
    typealias Output = ViewModelOutput
    
    struct ViewModelInput {
        // 网络请求类型
        let isCycleView: Bool
        
        init(isCycleView: Bool) {
            self.isCycleView = isCycleView
        }
    }
    
    struct ViewModelOutput {
        // tableView的sections数据
        let sections: Driver<[Section_HomeView]>
        // 外界通过该属性告诉viewModel加载数据（传入的值是为了标志是否重新加载）
        let requestCommond = PublishSubject<Bool>()
        // 告诉外界的tableView当前的刷新状态
        let refreshStatus = Variable<RefreshStatus>(.none)
        
        init(sections: Driver<[Section_HomeView]>) {
            self.sections = sections
        }
    }

}

extension Home_NewsViewModel{
    
    func getCycleimage() -> Observable<[Model_HomeView]>{
        
        return homePageTool.rx.request(HomePageApi.QueryInfoList(1, 1, 10)).asObservable().mapArray(Model_HomeView.self)
    }
}


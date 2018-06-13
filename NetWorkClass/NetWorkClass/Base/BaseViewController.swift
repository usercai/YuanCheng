//
//  BaseViewController.swift
//  SwiftFrame
//
//  Created by mac on 2017/11/16.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import RxSwift
import ImageViewer
class BaseViewController: UIViewController,BaseViewControllerProtocol {
    
    lazy var dataSource = NSMutableArray()
    let dis = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = WHITEColor
        
        initView()
        initData()
        // Do any additional setup after loading the view.
    }
    
    
    
    /// 请求数据
    func initData() {
        

    }
    
    /// 初始化页面
    func initView() {
        
    }
    


}

protocol BaseViewControllerProtocol {
    
    func initData()
    func initView()
    
}


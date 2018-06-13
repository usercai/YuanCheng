
//
//  TC_HomePageViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/15.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class TC_HomePageViewController: BaseViewController {
    
    private let noti = Home_NotificationViewController()
    private let work = TCHomePage_HomeWorkViewController()
    private let news = Home_NewsViewController()
    private lazy var segmentedControl:UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["资讯", "通知", "作业"])
        segmentedControl.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH - 150, height: 30)
        segmentedControl.tintColor = WHITEColor
        segmentedControl.backgroundColor = TINTCOLOR
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.setLayerForNormal(cornerRadius: segmentedControl.c_h/2, linecolorcolor: WHITEColor, linewidth: 1)

        return segmentedControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func initView() {
        
        
        self.view.addSubview(self.noti.view)
        self.view.addSubview(self.work.view)
        self.view.addSubview(self.news.view)
        
        
        self.segmentedControl.rx.selectedSegmentIndex.asObservable().subscribe(onNext: { (index) in
            if index == 0{
                self.news.view.isHidden = false
                self.noti.view.isHidden = true
                self.work.view.isHidden = true
            }else if index == 1{
                self.news.view.isHidden = true
                self.noti.view.isHidden = false
                self.work.view.isHidden = true
            }else {
                self.news.view.isHidden = true
                self.noti.view.isHidden = true
                self.work.view.isHidden = false
            }
        }).disposed(by: dis)
        self.navigationItem.titleView = segmentedControl
        
        let rightbutton = UIButton(frame: CGRect.init(x: 0, y: 0, width: 22, height: 22))
        rightbutton.setImage(#imageLiteral(resourceName: "homenavi_notification"), for: .normal)
        let rightitem = UIBarButtonItem(customView: rightbutton)
        self.navigationItem.rightBarButtonItem = rightitem
        
        rightbutton.rx.tap.asObservable().subscribe { (event) in
            
            let vc = Home_PushNotiViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            }.disposed(by: dis)
        
        
    }
}

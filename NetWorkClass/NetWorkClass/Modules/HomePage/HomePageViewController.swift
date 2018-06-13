//
//  HomePageViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/17.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import TwicketSegmentedControl


class HomePageViewController: BaseViewController {

    private lazy var segmentedControl:UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["资讯", "通知", "作业"])
        segmentedControl.frame = CGRect.init(x: 0, y: 0, width: 201, height: 29)
        segmentedControl.tintColor = WHITEColor
        segmentedControl.backgroundColor = TINTCOLOR
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.setLayerForNormal(cornerRadius: 15, linecolorcolor: WHITEColor, linewidth: 1)
        
        return segmentedControl
    }()
    let noti = Home_NotificationViewController()
    let work = Home_WorkViewController()
    let news = Home_NewsViewController()
    
    fileprivate var first = true

    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }

    override func initView() {

        
// MARK: - titileView

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
        
        self.view.addSubview(self.noti.view)
        self.view.addSubview(self.work.view)
        self.view.addSubview(self.news.view)
        

        self.noti.push = {
            vc in
            self.navigationController?.pushViewController(vc, animated: true)
        }

        self.work.push = {
            (arr:[Model_WorkBody]) in
            let vc = HomeWorkInfoViewController(data: arr)
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        var width = 60
        if iPhone5S {
            width = 30
        }
        /// leftitem
        let leftview = UIView.init(frame: CGRect.init(x: 0, y: 0, width: width, height: 30))
        let leftbutton = UIButton(frame: CGRect.init(x: 0, y: 0, width: width, height: 30))
        if KUserInfo.user.GradeName.count == 0 {
            leftbutton.setTitle("请选择班级", for: .normal)
        }else{
            leftbutton.setTitle(KUserInfo.user.GradeName, for: .normal)
        }
        leftbutton.setTitleColor(WHITEColor, for: .normal)
        leftbutton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        leftview.addSubview(leftbutton)
        
        leftbutton.rx.tap.subscribe(onNext: { () in
            if KUserInfo.user.GradeID == 0{
                GradeAlertView.shared.show()
            }else{
                CProgressHUD.showText(text: "年级已设置,如需修改请联系管理员")
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: dis)
        
        
//        let leftimage = UIImageView.init(frame: CGRect.init(x: leftbutton.frame.size.width, y: leftview.center.y - 5/2, width: 9, height: 5))
//        leftimage.image = #imageLiteral(resourceName: "arrows_down")
//        leftview.addSubview(leftimage)
        
        let leftitem = UIBarButtonItem(customView: leftview)
        self.navigationItem.leftBarButtonItem = leftitem
        
        let rightbutton = UIButton(frame: CGRect.init(x: 0, y: 0, width: 22, height: 22))
        rightbutton.setImage(#imageLiteral(resourceName: "homenavi_notification"), for: .normal)
        let rightitem = UIBarButtonItem(customView: rightbutton)
        self.navigationItem.rightBarButtonItem = rightitem
        
        rightbutton.rx.tap.asObservable().subscribe(onNext: { () in
            let vc = Home_PushNotiViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: dis)
        
        
    }
    

}


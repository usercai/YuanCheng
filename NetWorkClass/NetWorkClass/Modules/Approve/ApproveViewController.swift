//
//  ApproveViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/14.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class ApproveViewController: BaseViewController {

    private let segmente:UISegmentedControl = {
        let seg = UISegmentedControl(items: ["作业", "卷子", "问题"])
        seg.tintColor = WHITEColor
        seg.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH - 150, height: 30)
        seg.backgroundColor = TINTCOLOR
        seg.setLayerForNormal(cornerRadius: seg.c_h/2, linecolorcolor: WHITEColor, linewidth: 1)
        return seg
    }()
    
    private let homework = AP_HomeWorkViewController()
    private let question = AP_QuestionViewController()
    private let paper = AP_PaperViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        
        self.homework.push = {
            vc in
            self.navigationController?.pushViewController(vc, animated: true)
        }
        self.question.push = {
            vc in
            self.navigationController?.pushViewController(vc, animated: true)
        }
        self.paper.push = {
            vc in
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func initView() {
        self.segmente.selectedSegmentIndex = 0
        self.navigationItem.titleView = self.segmente
        
        self.segmente.rx.selectedSegmentIndex.subscribe(onNext: { (index) in
            if index == 0{
                self.homework.view.isHidden = false
                self.question.view.isHidden = true
                self.paper.view.isHidden = true
                
                
            }else if index == 1{
                self.homework.view.isHidden = true
                self.paper.view.isHidden = false
                self.question.view.isHidden = true
            }else {
                self.homework.view.isHidden = true
                self.paper.view.isHidden = true
                self.question.view.isHidden = false
            }
        }).disposed(by: dis)
        
        self.view.addSubview(self.homework.view)
        self.view.addSubview(self.paper.view)
        self.view.addSubview(self.question.view)
        
    }

}



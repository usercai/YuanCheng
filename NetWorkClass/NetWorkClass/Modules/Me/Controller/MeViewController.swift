//
//  MeViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/17.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class MeViewController: BaseViewController {

    lazy var viewModel = MeViewModel()

    
    
    lazy var tableView:UITableView = {
        
        let table = UITableView()
        table.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        table.delegate = self.viewModel
        table.dataSource = self.viewModel
        table.tableFooterView = UIView(frame: CGRect.zero)
        return table
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.registerCell(tableView: self.tableView)
        self.view.addSubview(self.tableView)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    

    override func initView() {
        
        self.tableView.rx.itemSelected.asObservable().subscribe(onNext: { (index) in
            
            if KUserInfo.UserRole == .Student{
                //学生端
                if index.row == 0{
                    let vc = ExercisesRecordViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }else if index.row == 1{
                    let vc = Me_QuestionViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }else if index.row == 2{
                    let vc = Me_HomeWorkViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }else{
                //老师端
                if index.row == 0{
                    let vc = Me_TeacherPaperViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }else if index.row == 1{
                    let vc = TME_QuestionViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }else if index.row == 2{
                    let vc = TME_HomeWorkViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }

            
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: dis)
        
    }

}



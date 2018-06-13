//
//  AP_PaperViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/14.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class AP_PaperViewController: BaseTableViewController {

    let viewmodel = AP_PaperViewModel()
    var push:PushViewControllerBlock? = nil
    private var gradesubject:[Model_GradeSubject] = []
    
    private var btn:UIButton? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func initData() {
        
        ApproveTool.rx.request(ApproveApi.QueryExaminSubject()).asObservable().mapArray(Model_GradeSubject.self).subscribe(onNext: { (models) in
            if models.count != 0{
                self.gradesubject = models
                self.getInfoData(model: models.first!)
            }
        }, onError: { (error) in
            
        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)
        
    }
    
    override func RegisterCell() {
        self.tableView.register(UINib.init(nibName: "ApproveTableViewCell", bundle: nil), forCellReuseIdentifier: "ApproveTableViewCell")

    }
    
    func getInfoData(model:Model_GradeSubject) {


        let output = self.viewmodel.getDataList(gradeId: model.GradeID, subjectid: model.SubjectID)
        output.models.asDriver().drive(onNext: { (models) in
            self.dataSource = NSMutableArray(array: models)
            self.tableView.reloadData()
        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)
        
        output.refreshStatus.asObservable().subscribe(onNext: { (status) in
            self.refresh(status: status)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: dis)
        
        tableView.mj_header = CRefresh.headerRefresh(refresh: {
            
            output.requestCommond.onNext(true)
        })
        tableView.mj_footer = CRefresh.footerRefresh(refresh: {
            output.requestCommond.onNext(false)
        })
        
        tableView.mj_header.beginRefreshing()
    }
    override func initView() {
        
        self.tableView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - NaviBarHeight - TabBarHeight)
        self.btn = UIButton(type: UIButtonType.custom)
        self.btn?.setBackgroundImage(#imageLiteral(resourceName: "APProve_select"), for: .normal)
//        print(self.tableView.c_h)
//        print(SCREEN_HEIGHT)
        self.btn?.frame = CGRect(x:  SCREEN_WIDTH - 80, y:  self.tableView.c_h - NaviBarHeight - 30, width: 60, height: 60)

        self.btn?.rx.tap.asObservable().subscribe { (event) in
            
            if self.gradesubject.count == 0{
                CProgressHUD.showText(text: "暂无其他信息")
                return
            }
            
            AppTool.showAlertSheet(title: "我的执教", actions: self.gradesubject, QAction: { (model) in
                self.getInfoData(model: model)
            })
            
        }.disposed(by: dis)
        
        self.tableView.addSubview(self.btn!)
    }
}

extension AP_PaperViewController{
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ApproveTableViewCell", for: indexPath) as! ApproveTableViewCell
        let model : Model_TestPaper = self.dataSource[indexPath.row] as! Model_TestPaper
        cell.cellformodel(model: model)
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 67
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model : Model_TestPaper = self.dataSource[indexPath.row] as! Model_TestPaper

        let vc = AP_PaperApproveViewController(examID: model.ExamID, Count: model.Count, StudentId: model.StudentID)
        self.push?(vc)
    }
}

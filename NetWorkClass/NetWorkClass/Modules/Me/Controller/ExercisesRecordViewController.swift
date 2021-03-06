//
//  ExercisesRecordViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/4.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class ExercisesRecordViewController: BaseTableViewController {

    private var isFirstIn: Bool = true
    
    let viewmodel = ExercisesRecordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "习题记录"
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !self.isFirstIn {
            
            tableView.mj_header.beginRefreshing()
        }
    }
    
    override func initView() {
        
        
    }
    
    override func RegisterCell() {
        
        self.tableView.register(UINib.init(nibName: "Me_HomeWorkTableViewCell", bundle: nil), forCellReuseIdentifier: "Me_HomeWorkTableViewCell")
    }
    
    override func initData() {
        
        let output = self.viewmodel.getDataList()
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
}

extension ExercisesRecordViewController{
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Me_HomeWorkTableViewCell", for: indexPath) as! Me_HomeWorkTableViewCell
        let model = self.dataSource[indexPath.row] as! Model_Exam

        cell.cellforModel(model: model)
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.dataSource[indexPath.row] as! Model_Exam
        MeTool.rx.request(MeApi.QueryRead(2, model.ExamID)).asObservable().subscribe(onNext: { (res) in
            
            res.C_mapjson(success: { (dic) in
                let vc = Me_ExercisesInfoViewController(examID: model.ExamID, Count: model.Count)
                vc.title = model.ExamName
                self.navigationController?.pushViewController(vc, animated: true)
                
                self.isFirstIn = false
                
            }, falue: { (code, msg) in
                CProgressHUD.showText(text: "修改失败")
                
            })
            
        }, onError: { (error) in
            CProgressHUD.showText(text: "修改失败")
            
        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)

        
    }
}

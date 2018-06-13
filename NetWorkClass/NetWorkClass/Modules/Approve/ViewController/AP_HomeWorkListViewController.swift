//
//  AP_HomeWorkInfoViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/15.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class AP_HomeWorkListViewController: BaseTableViewController {

    let viewmodel = AP_HomeWorkInfoViewModel()
    private var gradeid = 0
    private var subjectid = 0
    private var datetime = ""
    var push:PushViewControllerBlock? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.tableView.mj_header != nil {
            tableView.mj_header.beginRefreshing()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "作业"
        // Do any additional setup after loading the view.
    }
    convenience init(gradeid:Int,subjectid:Int,datetime:String) {
        self.init()
        self.gradeid = gradeid
        self.subjectid = subjectid
        self.datetime = datetime
    }

    override func initData() {
        let output = self.viewmodel.getDataList(gradeid: self.gradeid, subjectid: self.subjectid, datetime: self.datetime)
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
    
    override func RegisterCell() {
        self.tableView.register(UINib.init(nibName: "ApproveTableViewCell", bundle: nil), forCellReuseIdentifier: "ApproveTableViewCell")
    }
    
}

extension AP_HomeWorkListViewController{
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ApproveTableViewCell", for: indexPath) as! ApproveTableViewCell
        let model = self.dataSource[indexPath.row] as! Model_HomeWork
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
        let model = self.dataSource[indexPath.row] as! Model_HomeWork
        let vc = AP_HomeWorkApproveViewController(model: model)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

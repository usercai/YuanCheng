//
//  AP_QuestionViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/14.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class AP_QuestionViewController: BaseTableViewController {

    let viewmodel = AP_QuestionViewModel()
    var push:PushViewControllerBlock? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    override func initView() {
        
    }
    override func RegisterCell() {
        self.tableView.register(UINib.init(nibName: "ApproveTableViewCell", bundle: nil), forCellReuseIdentifier: "ApproveTableViewCell")
    }

}

extension AP_QuestionViewController{
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ApproveTableViewCell", for: indexPath) as! ApproveTableViewCell
        let model : Model_QuestionList = self.dataSource[indexPath.row] as! Model_QuestionList
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
        let model : Model_QuestionList = self.dataSource[indexPath.row] as! Model_QuestionList
        let vc = AP_QuestionInfoViewController(model: model)
        self.push?(vc)
    }
}

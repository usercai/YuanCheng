//
//  Home_PushNotiViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/10.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class Home_PushNotiViewController: BaseTableViewController {

    let viewmodel = Home_PushNotiViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "消息列表"
        // Do any additional setup after loading the view.
    }

    override func RegisterCell() {
        self.tableView.register(UINib.init(nibName: "Push_NotiTableViewCell", bundle: nil), forCellReuseIdentifier: "Push_NotiTableViewCell")
        self.tableView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-StateBarHeight-NaviBarHeight)

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

extension Home_PushNotiViewController{
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Push_NotiTableViewCell", for: indexPath) as! Push_NotiTableViewCell
        let model = self.dataSource[indexPath.row] as! Model_PushList
        cell.cellforModel(model: model)
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

    }
}

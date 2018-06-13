//
//  Home_NotificationViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/20.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class Home_NotificationViewController: BaseTableViewController {

    let viewmodel = Home_NotificationViewModel()
    
    var push:PushViewControllerBlock? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }

    override func initView() {

        
    }
    
    override func initData() {
        
        let output = self.viewmodel.getNoticeList()
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
        self.tableView.register(UINib.init(nibName: "Home_NewsNoImageTableViewCell", bundle: nil), forCellReuseIdentifier: "Home_NewsNoImageTableViewCell")

        self.tableView.register(UINib.init(nibName: "Home_NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "Home_NewsTableViewCell")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}

extension Home_NotificationViewController{
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = self.dataSource[indexPath.row] as! Model_HomeView
        if model.Picture != "" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Home_NewsTableViewCell", for: indexPath) as! Home_NewsTableViewCell
            cell.cellforModel(model: model)
            cell.selectionStyle = .none
            return cell
        }
        
        let noimagecell = tableView.dequeueReusableCell(withIdentifier: "Home_NewsNoImageTableViewCell", for: indexPath) as! Home_NewsNoImageTableViewCell
        noimagecell.cellforModel(model: model)
        noimagecell.selectionStyle = .none
        return noimagecell
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = self.dataSource[indexPath.row] as! Model_HomeView
        if model.Picture != "" {
            return 190/2
        }
        return 115/2
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.dataSource[indexPath.row] as! Model_HomeView
        
//        let vc = Home_NewsInfoViewController(noticeId: model.NoticeID)
//        vc.title = model.Title
        let vc = Home_NewsHtmlViewController(noticeId: model.NoticeID)
        AppTool.currentViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
    
}

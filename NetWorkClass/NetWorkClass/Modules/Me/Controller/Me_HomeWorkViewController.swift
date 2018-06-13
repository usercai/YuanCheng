//
//  Me_HomeWorkViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/4.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class Me_HomeWorkViewController: BaseTableViewController {
    
    private var isFirstIn:Bool = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !isFirstIn {
            
            self.tableView.mj_header.beginRefreshing()
        }
    }
    
    let viewmodel = Me_HomeworkViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "作业记录"
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
    
    override func initView() {
        
    }
}
extension Me_HomeWorkViewController{
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Me_HomeWorkTableViewCell", for: indexPath) as! Me_HomeWorkTableViewCell
        let model = self.dataSource[indexPath.row] as! Model_HomeWork
        cell.cellforModel(model: model)
        cell.selectionStyle = .none
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
        
        var model = self.dataSource[indexPath.row] as! Model_HomeWork
        
        MeTool.rx.request(MeApi.QueryRead(4, model.HomeworkId)).asObservable().subscribe(onNext: { (res) in
            
            res.C_mapjson(success: { (dic) in
             
                let vc = Me_HomeWorkInfoViewController(HomeWorkId: model.HomeworkId)
             
                self.isFirstIn = false
                model.IsRead = 1
                
                self.navigationController?.pushViewController(vc, animated: true)
                
            }, falue: { (code, msg) in
                
                CProgressHUD.showText(text: "修改失败")
                
            })
            
        }, onError: { (error) in
            CProgressHUD.showText(text: "修改失败")
            
        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)

    }
    
    


        
    
}

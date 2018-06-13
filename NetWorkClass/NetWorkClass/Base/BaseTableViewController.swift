//
//  BaseTableViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/20.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import MJRefresh
import RxSwift
protocol BaseTableViewControllerProtocol{
    
    /// 注册cell
    func RegisterCell()
    
}

class BaseTableViewController: BaseViewController,BaseTableViewControllerProtocol {
    
    
    lazy var tableView:UITableView = {
        
        let table = UITableView()
        table.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-TabStateBarHeight-NaviBarHeight)
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView(frame: CGRect.zero)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        table.separatorColor = LineColor_d9d9d9
        return table
        
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 11.0, *) {
            
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.never
            
        } else {
            
            self.automaticallyAdjustsScrollViewInsets = false
        }
        self.view.addSubview(self.tableView)
        RegisterCell()
        initNoDataView()
        initData()
    }
    
    //注册cell
    func RegisterCell() {
        
    }
    
//    func beginUpRefresh(){
//        
//        self.dataSource.removeAllObjects()
//        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
//            self.initData()
//        })
//    }
    
    override func initData(){
        
        
    }


    
    func initNoDataView() {
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
    }

    func refresh(status:RefreshStatus){
        switch status {
        case .beingHeaderRefresh:
            self.tableView.mj_header.beginRefreshing()
        case .endHeaderRefresh:
            self.tableView.mj_header.endRefreshing()
        case .beingFooterRefresh:
            self.tableView.mj_footer.beginRefreshing()
        case .endFooterRefresh:
            self.tableView.mj_footer.endRefreshing()
        case .noMoreData:
            self.tableView.mj_footer.endRefreshingWithNoMoreData()

        default:
            break
        }
    }
    


}

extension BaseTableViewController:UITableViewDataSource,UITableViewDelegate{
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.selectionStyle = .none

        return cell
    }
}

extension BaseTableViewController:DZNEmptyDataSetSource,DZNEmptyDataSetDelegate{
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        
        return #imageLiteral(resourceName: "暂无数据")
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        
        let dict = [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14)]
        
        return NSAttributedString(string: "暂无数据", attributes: dict)
    }
}

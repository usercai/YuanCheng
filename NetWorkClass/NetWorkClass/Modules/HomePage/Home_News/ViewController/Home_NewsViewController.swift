//
//  Home_NewsViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/20.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import SDCycleScrollView
import RxDataSources
import MJRefresh

class Home_NewsViewController: BaseTableViewController {

    let viewmodel = Home_NewsViewModel()
    
    var cycleScrollView:SDCycleScrollView?

    var vmOutput : Home_NewsViewModel.Output?
    
    private var cycledataSource:[Model_HomeView] = []
    var push:PushViewControllerBlock? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCycleImage()

        
    }
    
    func initCycleImage() {
        
        self.viewmodel.getCycleimage().subscribe(onNext: { (models) in
            var imagurl:[String] = []
            var title:[String] = []
            
            for model in models{
                imagurl.append(model.Picture.UrlStr())
                title.append(model.Title)
                
            }
            self.cycledataSource = models
            self.cycleScrollView?.imageURLStringsGroup = imagurl
//            self.cycleScrollView?.titlesGroup = title
        }).disposed(by: dis)
    }
    
    override func initData() {

        let out = viewmodel.transform(input: Home_NewsViewModel.ViewModelInput.init(isCycleView: false))

        out.sections.asDriver().drive(onNext: { (models) in
            self.dataSource = NSMutableArray.init(array: models)
            self.tableView.reloadData()
        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)
        
        out.refreshStatus.asObservable().subscribe(onNext: {[weak self] status in
            switch status {
            case .beingHeaderRefresh:
                self?.tableView.mj_header.beginRefreshing()
            case .endHeaderRefresh:
                self?.tableView.mj_header.endRefreshing()
            case .beingFooterRefresh:
                self?.tableView.mj_footer.beginRefreshing()
            case .endFooterRefresh:
                self?.tableView.mj_footer.endRefreshing()
            case .noMoreData:
                self?.tableView.mj_footer.endRefreshingWithNoMoreData()
            default:
                break
            }
        }).disposed(by: dis)
        
        
        tableView.mj_header = CRefresh.headerRefresh(refresh: {
            
            out.requestCommond.onNext(true)
        })
        tableView.mj_footer = CRefresh.footerRefresh(refresh: {
            out.requestCommond.onNext(false)
        })
        
        tableView.mj_header.beginRefreshing()


        
    }
    override func RegisterCell() {
        self.tableView.register(UINib.init(nibName: "Home_NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "Home_NewsTableViewCell")
        self.tableView.register(UINib.init(nibName: "Home_NewsNoImageTableViewCell", bundle: nil), forCellReuseIdentifier: "Home_NewsNoImageTableViewCell")
//        self.tableView.rx.setDelegate(self).disposed(by: dis)
        
    }
    override func initView() {
        
        self.cycleScrollView = SDCycleScrollView(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 200), delegate: self, placeholderImage: #imageLiteral(resourceName: "noDataImage"))
        
//        self.view.addSubview(self.cycleScrollView!)
        
        self.tableView.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - NaviBarHeight - TabBarHeight)
        self.tableView.tableHeaderView = self.cycleScrollView
    }
}

extension Home_NewsViewController{
    

}

extension Home_NewsViewController{
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let section = self.dataSource[indexPath.section] as! Section_HomeView
        let model = section.items[indexPath.row]
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = self.dataSource[section] as! Section_HomeView

        return section.items.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = self.dataSource[indexPath.section] as! Section_HomeView
        let model = section.items[indexPath.row]
        if model.Picture != "" {
            return 190/2
        }
        return 115/2
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = self.dataSource[indexPath.section] as! Section_HomeView
        let model = section.items[indexPath.row]
        let vc = Home_NewsHtmlViewController(noticeId: model.NoticeID)
        
//        let vc = Home_NewsInfoViewController(noticeId: model.NoticeID)
        
        AppTool.currentViewController()?.navigationController?.pushViewController(vc, animated: true)
    }

}

extension Home_NewsViewController : SDCycleScrollViewDelegate{
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        let model = self.cycledataSource[index]
        let vc = Home_NewsHtmlViewController(noticeId: model.NoticeID)
        AppTool.currentViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didScrollTo index: Int) {
        
    }
}


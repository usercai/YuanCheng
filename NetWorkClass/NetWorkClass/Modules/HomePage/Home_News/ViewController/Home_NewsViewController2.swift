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

class Home_NewsViewController2: BaseTableViewController {
    
    let viewmodel = Home_NewsViewModel()
    
    var cycleScrollView:SDCycleScrollView?
    
    var vmOutput : Home_NewsViewModel.Output?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //        RegisterCell()

        
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
        //        self.tableView.rx.setDelegate(self).disposed(by: dis)
        
        self.view.addSubview(self.tableView)
    }
    override func initView() {
        
        self.cycleScrollView = SDCycleScrollView(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 100), delegate: self, placeholderImage: #imageLiteral(resourceName: "login_teacherDeep"))
        self.cycleScrollView?.localizationImageNamesGroup = [#imageLiteral(resourceName: "login_teacherDeep"),#imageLiteral(resourceName: "login_studentDeep")]
        self.view.addSubview(self.cycleScrollView!)
        
        self.tableView.frame = CGRect.init(x: 0, y: (self.cycleScrollView?.frame.maxY)!, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 100 - 64 - 49)
    }
}



extension Home_NewsViewController2{
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Home_NewsTableViewCell", for: indexPath) as! Home_NewsTableViewCell
        let section = self.dataSource[indexPath.section] as! Section_HomeView
        if section.items.count != 0 {
            let model = section.items[indexPath.row] as! Model_HomeView
            cell.cellforModel(model: model)
            
        }
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = self.dataSource[section] as! Section_HomeView
        
        return section.items.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension Home_NewsViewController2 : SDCycleScrollViewDelegate{
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        
    }
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didScrollTo index: Int) {
        
    }
}



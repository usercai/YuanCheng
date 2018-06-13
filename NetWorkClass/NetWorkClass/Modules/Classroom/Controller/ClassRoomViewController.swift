//
//  ClassRoomViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/17.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class ClassRoomViewController: BaseTableViewController {

    
    let viewmodel = ClassRoomViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewmodel.registerCell(tableView: self.tableView)

        self.view.addSubview(self.tableView)
        
    }
    
    override func initData() {
        
        
        let output = self.viewmodel.getSubjectList()
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
//        tableView.mj_footer = CRefresh.footerRefresh(refresh: {
//            output.requestCommond.onNext(false)
//        })
        
        tableView.mj_header.beginRefreshing()
        
    }
    
    

    override func RegisterCell() {
        self.tableView.register(UINib.init(nibName: "ClassRoomTableViewCell", bundle: nil), forCellReuseIdentifier: "ClassRoomTableViewCell")
        self.tableView.separatorStyle = .none   
    }

}

extension ClassRoomViewController{
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClassRoomTableViewCell", for: indexPath) as! ClassRoomTableViewCell
        let model : Model_Subject = self.dataSource[indexPath.row] as! Model_Subject
        cell.title?.text = model.SubjectName
//        cell.headimage?.image = UIImage.init(named: model.SubjectName.transformToPinYin())
        cell.headimage.c_setImage(url: model.Icon, placeholderImage: UIImage.init(named: model.SubjectName.transformToPinYin()) ?? #imageLiteral(resourceName: "yuwen"))
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
        let model : Model_Subject = self.dataSource[indexPath.row] as! Model_Subject
        let vc = ClassRoomChapterViewController(subId: model.SubjectID)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

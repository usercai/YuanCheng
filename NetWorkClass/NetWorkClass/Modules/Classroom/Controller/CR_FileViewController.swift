//
//  CR_FileViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/29.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import Moya
class CR_FileViewController: BaseTableViewController {

    let prefix = MoyaProvider<ClassRoomApi>()
    var cId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "资料"
        
    }
    convenience init(id:Int) {
        self.init()
        self.cId = id
        
    }


    override func initData() {
        
        self.prefix.rx.request(ClassRoomApi.QueryFile(self.cId)).asObservable().mapArray(Model_File.self).subscribe(onNext: { (models) in
            
            self.dataSource = NSMutableArray.init(array: models)
            self.tableView.reloadData()
        }, onError: { (error) in
            
        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)
    }
    

    override func RegisterCell() {
        self.tableView.register(UINib.init(nibName: "FileTableViewCell", bundle: nil), forCellReuseIdentifier: "FileTableViewCell")
        self.tableView.autoresizesSubviews = true
        self.tableView.separatorStyle = .none
    }
    
    
}

extension CR_FileViewController{
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.dataSource[indexPath.row] as! Model_File
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FileTableViewCell", for: indexPath) as! FileTableViewCell
        cell.filename?.text = model.FileTitle
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.dataSource[indexPath.row] as! Model_File

        let vc = FindFileViewController(fileContent: model.FileContent, filename: model.FileTitle, filePic: model.Picture)
        
        AppTool.currentViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
}

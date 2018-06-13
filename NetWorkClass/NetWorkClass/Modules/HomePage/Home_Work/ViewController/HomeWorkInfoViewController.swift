//
//  HomeWorkInfoViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/1.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class HomeWorkInfoViewController: BaseTableViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "作业"
        // Do any additional setup after loading the view.
    }
    
    convenience init(data:[Model_WorkBody]) {
        self.init()
        
        self.dataSource = NSMutableArray.init(array: data)
        self.tableView.reloadData()
    }
    
    override func initData() {
        
    }

    override func RegisterCell() {
        self.tableView.register(UINib.init(nibName: "HomeWorkTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeWorkTableViewCell")
        
    }
}

extension HomeWorkInfoViewController{
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeWorkTableViewCell", for: indexPath) as! HomeWorkTableViewCell
        let model : Model_WorkBody = self.dataSource[indexPath.row] as! Model_WorkBody
        cell.cellforModel(model: model)
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model : Model_WorkBody = self.dataSource[indexPath.row] as! Model_WorkBody
        if model.HomeworkImg == "" {
            return 40
        }
        
        return 150
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model : Model_WorkBody = self.dataSource[indexPath.row] as! Model_WorkBody

        let vc = DoHomeWorkViewController(homeworkid: model.HomeworkID)
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
}

//
//  TL_ ExercisesTypeViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/27.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

/// 获取练习题类型列表
class TL_ExercisesTypeViewController: BaseTableViewController {

    let viewmodel = TL_ExerciseTypeViewModel()
    
    var sId = 0
    
    convenience init(sId:Int) {
        self.init()
        self.sId = sId
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func RegisterCell() {
        
        self.tableView.separatorStyle = .none
        self.tableView.register(UINib.init(nibName: "QuestionTypeTableViewCell", bundle: nil), forCellReuseIdentifier: "QuestionTypeTableViewCell")
    }

    override func initData() {
        let output = self.viewmodel.getDataList(sId: self.sId)
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

        
        tableView.mj_header.beginRefreshing()
    }
    
}

extension TL_ExercisesTypeViewController{
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionTypeTableViewCell", for: indexPath) as! QuestionTypeTableViewCell
        let model : Model_ExercisesType = self.dataSource[indexPath.row] as! Model_ExercisesType
        cell.cellForModel(model: model)
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let model : Model_ExercisesType = self.dataSource[indexPath.row] as! Model_ExercisesType

        let vc = TL_ExercisesPageViewController(typeId: model.QuestionTypeID, gid: KUserInfo.user.GradeID, sId: self.sId, count:model.Count)
        vc.title = model.TypeName
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

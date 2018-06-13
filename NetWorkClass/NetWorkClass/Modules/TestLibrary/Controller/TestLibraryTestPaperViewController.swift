//
//  TestLibraryTestPaperViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/27.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class TestLibraryTestPaperViewController: BaseTableViewController {

    let viewmodel = TL_TestPagerViewModel()
    var sId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    convenience init(sId:Int){
        self.init()
        self.sId = sId
    }
    override func RegisterCell() {
        
        self.tableView.register(UINib.init(nibName: "TestPaperTableViewCell", bundle: nil), forCellReuseIdentifier: "TestPaperTableViewCell")
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
//        tableView.mj_footer = CRefresh.footerRefresh(refresh: {
//            output.requestCommond.onNext(false)
//        })
        
        tableView.mj_header.beginRefreshing()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension TestLibraryTestPaperViewController{
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestPaperTableViewCell", for: indexPath) as! TestPaperTableViewCell
        let model : Model_TestPaper = self.dataSource[indexPath.row] as! Model_TestPaper
        cell.cellforModel(model: model)
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let model = self.dataSource[indexPath.row] as! Model_TestPaper
        
        let vc = TL_TestPaperInfoViewController(examID: model.ExamID, Count: model.Count)
        vc.title = model.ExamName
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

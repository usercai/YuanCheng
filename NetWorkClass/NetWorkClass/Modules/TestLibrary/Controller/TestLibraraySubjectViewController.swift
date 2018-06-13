//
//  TestLibrarayChapterViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/25.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class TestLibraraySubjectViewController: BaseTableViewController {

    let viewmodel = TestLibrarySubjectViewModel()
    var api:TestLibraryApi = .ExamSubjectList(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    convenience init(Api:TestLibraryApi) {
        self.init()
        self.api = Api
        switch self.api {
        case .ExamSubjectList(_):
            self.title = "模拟题"
        default:
            self.title = "练习题"
        }
    }
    
    override func RegisterCell() {
        self.tableView.register(UINib.init(nibName: "ClassRoomTableViewCell", bundle: nil), forCellReuseIdentifier: "ClassRoomTableViewCell")
        self.tableView.separatorStyle = .none
        
    }
    override func initData() {
        
        let output = self.viewmodel.getDataList(api: self.api)
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
//        
        tableView.mj_header.beginRefreshing()
    }

}

extension TestLibraraySubjectViewController{
    
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

        switch self.api {
        case .ExamSubjectList(_):
//            self.title = "模拟题"
            let vc = TestLibraryTestPaperViewController(sId: model.SubjectID)
            vc.title = model.SubjectName
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            
            let vc = TL_ExercisesTypeViewController(sId: model.SubjectID)
            vc.title = model.SubjectName
            self.navigationController?.pushViewController(vc, animated: true)
//            self.title = "练习题"
        }

    }
}

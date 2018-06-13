//
//  AP_HomeWorkViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/14.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class TME_HomeWorkViewController: BaseViewController {

    var first = true
    var push:PushViewControllerBlock? = nil
    
    fileprivate lazy var mycalendar = MyCalendarView(Api:.TeacherMeHomeWork,frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 300))
    fileprivate var selectSection = 0
    private lazy var tableView:UITableView = {
        
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.emptyDataSetSource = self
        table.emptyDataSetDelegate = self
        table.tableFooterView = UIView(frame: CGRect.zero)
        table.separatorStyle = .none
        table.register(UINib.init(nibName: "HomeWork_SubjectTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeWork_SubjectTableViewCell")
        return table
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "作业记录"
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Commit frames' updates
        self.mycalendar.updateCalendar()
        if self.first {
            self.mycalendar.getDate(date: Date())
            self.initMyData()
            self.first = false
        }

    }
    
    
    override func initView() {
        self.tableView.frame = CGRect.init(x: 0, y: self.mycalendar.frame.maxY + 20, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - self.mycalendar.frame.maxY - 30)
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.mycalendar)
        
        NotificationCenter.default.addObserver(self, selector: #selector(initData(noti:)), name: NSNotification.Name.init("nowDate"), object: nil)
        
        self.view.backgroundColor = WHITEColor
    }
    
    func initMyData() {
        
        let time = Date().dateYearMonthDayString()
        print(time)
        TME_Tool.rx.request(TME_API.QuerySubject(time)).asObservable().mapArray(Model_GradeSubject.self).subscribe(onNext: { (work) in
            self.dataSource = NSMutableArray(array: work)
            self.tableView.reloadData()
        }, onError: { (error) in

        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)
    }
    
    @objc func initData(noti:Notification) {

        let role:UserRole = noti.userInfo!["role"] as! UserRole
        if role == .Student {
            return
        }
        
        
        let date = noti.userInfo!["date"] ?? ""
        guard let day = date as? String else {
            return
        }
        TME_Tool.rx.request(TME_API.QuerySubject(day)).asObservable().mapArray(Model_GradeSubject.self).subscribe(onNext: { (work) in
            self.dataSource = NSMutableArray(array: work)
            self.tableView.reloadData()
        }, onError: { (error) in
            self.dataSource.removeAllObjects()
            self.tableView.reloadData()
        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)
        
    }
    
}

extension TME_HomeWorkViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeWork_SubjectTableViewCell", for: indexPath) as! HomeWork_SubjectTableViewCell
        cell.selectionStyle = .none
        if let model = dataSource[indexPath.row] as? Model_GradeSubject {
            cell.cellformodel(model: model)
        }
        cell.xuhao?.text = (indexPath.row + 1).string()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let model = dataSource[indexPath.row] as? Model_GradeSubject {
            let vc = TME_HomeWorkListViewController(gradeid: model.GradeID, subjectid: model.SubjectID, datetime: self.mycalendar.nowdata)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
    
    
}
extension TME_HomeWorkViewController:DZNEmptyDataSetSource,DZNEmptyDataSetDelegate{

    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        let dict = [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14)]
        
        return NSAttributedString(string: "暂无数据", attributes: dict)
    }
    
}


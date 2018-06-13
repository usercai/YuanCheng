//
//  Home_WorkViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/20.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import CVCalendar
import RxSwift
import RxCocoa
import Moya
import DZNEmptyDataSet

class Home_WorkViewController: BaseViewController {
    
    private var first = true
    typealias ABlock = ([Model_WorkBody]) -> ()
    //记录选择的section
    private var selectSection:Int? = 0
    //记录当前的date
    private var date = ""
    var push : ABlock? = nil
    
    let mycalendar = MyCalendarView(Api:.StudentHomeWork,frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 300))
    let pre = MoyaProvider<HomePageApi>()
    
    lazy var tableView:UITableView = {
        
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
//        table.emptyDataSetSource = self
//        table.emptyDataSetDelegate = self
        table.tableFooterView = UIView(frame: CGRect.zero)
        table.register(UINib.init(nibName: "TCHome_WorkTableViewCell", bundle: nil), forCellReuseIdentifier: "TCHome_WorkTableViewCell")
        table.register(TCHomeWork_SubjectHeaderView.self, forHeaderFooterViewReuseIdentifier: "TCHomeWork_SubjectHeaderView")
        table.separatorStyle = .none
        return table
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        
        self.tableView.frame = CGRect.init(x: 0, y: self.mycalendar.frame.maxY, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - self.mycalendar.frame.maxY - TabBarHeight - NaviBarHeight)
        self.view.addSubview(self.tableView)

        NotificationCenter.default.addObserver(self, selector: #selector(initData(noti:)), name: NSNotification.Name.init("nowDate"), object: nil)
        

        
        // Do any additional setup after loading the view.
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Commit frames' updates
        self.mycalendar.updateCalendar()
        if self.first {
            self.mycalendar.getDate(date: Date())
            self.getDate()
            self.first = false
        }
        
    }
    
    override func initView() {
        
        self.view.addSubview(self.mycalendar)
        
    }

    func getDate() {
        self.mycalendar.getDate(date: Date())
        initNowData()
    }
    
    @objc func initData(noti:Notification) {
        
        let role:UserRole = noti.userInfo!["role"] as! UserRole
        if role == .Teacher {
            return
        }
        
        let date = noti.userInfo!["date"] ?? ""
        self.pre.rx.request(HomePageApi.QuerySubjectData(date as! String)).asObservable().mapArray(Model_GradeSubject.self).subscribe(onNext: { (work) in
            self.dataSource = NSMutableArray(array: work)
            self.tableView.reloadData()
        }, onError: { (error) in
            self.dataSource.removeAllObjects()
            self.tableView.reloadData()
        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)
        
    }
    
    func initNowData() {
        
        let time = Date().dateYearMonthDayString()
        
        self.pre.rx.request(HomePageApi.QuerySubjectData(time)).asObservable().mapArray(Model_GradeSubject.self).subscribe(onNext: { (work) in
            self.dataSource = NSMutableArray(array: work)
            self.tableView.reloadData()
        }, onError: { (error) in
            print(error)
        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)
        
    }
    
    
}

extension Home_WorkViewController:UITableViewDelegate,UITableViewDataSource{
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TCHome_WorkTableViewCell", for: indexPath) as! TCHome_WorkTableViewCell
        cell.selectionStyle = .none
        let model = self.dataSource[indexPath.section] as! Model_GradeSubject
        if model.HomeworkList?.count != 0{
            cell.cellformodel(model: model.HomeworkList![indexPath.row], row: indexPath.row) 
            if indexPath.row == 0{
                cell.firstCell()
            }else if indexPath.row == model.HomeworkList!.count - 1 {
                cell.endCell()
            }else{
                cell.normalCell()
            }
            if model.HomeworkList!.count == 1{
                cell.oneCell()
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TCHomeWork_SubjectHeaderView") as! TCHomeWork_SubjectHeaderView
        let model = self.dataSource[section] as! Model_GradeSubject
        let tap = UITapGestureRecognizer()
        tap.rx.event.asObservable().subscribe(onNext: { (tap) in
            if self.selectSection == section{
                self.selectSection = nil
            }else{
                self.selectSection = section
            }
            self.tableView.reloadData()
        }).disposed(by: dis)
        header.contentLabel.addGestureRecognizer(tap)
        header.cellForModel(model: model)
        header.headLabel.text = (section + 1).string()
        header.buzhibtn.isHidden = true
        header.contentView.backgroundColor = WHITEColor
        return header
    }
    
    @objc func buzhizuoye(btn:UIButton) {
        let tag = btn.tag
        let model = self.dataSource[tag] as! Model_GradeSubject
        let vc = TeacherAssignHomeworkViewController(model: model, time: self.date)
        
        AppTool.currentViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = self.dataSource[section] as! Model_GradeSubject
        
        if self.selectSection == nil {
            return 0
        }
        if section == self.selectSection {
            return model.HomeworkList?.count ?? 0
        }
        return 0
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        let model : Model_GradeSubject = self.dataSource[indexPath.row] as! Model_GradeSubject
        if model.HomeworkList?.count != 0 {
            let m:Model_HomeWork = model.HomeworkList![indexPath.row]
            let vc = DoHomeWorkViewController(homeworkid: m.HomeworkID)
            
            AppTool.currentViewController()?.navigationController?.pushViewController(vc, animated: true)
        }


        
    }
    

}


extension Home_WorkViewController : DZNEmptyDataSetSource,DZNEmptyDataSetDelegate{

    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        
        return #imageLiteral(resourceName: "暂无数据")
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        let dict = [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14)]
        
        return NSAttributedString(string: "暂无数据", attributes: dict)
    }
}



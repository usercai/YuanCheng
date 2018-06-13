//
//  ClassRoomChapterViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/24.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class ClassRoomChapterViewController: BaseTableViewController {

    let viewmodel = ClassRoomChapterViewModel()
    
    var subId = 0
    
    var Section = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    convenience init(subId:Int) {
        self.init()
        
        self.subId = subId
    }

    override func RegisterCell() {
        
        self.tableView.register(UINib.init(nibName: "ChapterTableViewCell", bundle: nil), forCellReuseIdentifier: "ChapterTableViewCell")
        self.tableView.register(UINib.init(nibName: "LessonTableViewCell", bundle: nil), forCellReuseIdentifier: "LessonTableViewCell")
        self.tableView.separatorStyle = .none

    }

    override func initData() {
        
        self.title = "课堂章节"
        
        
        let output = self.viewmodel.getNoticeList(subId: self.subId)
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

}

extension ClassRoomChapterViewController{
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LessonTableViewCell", for: indexPath) as! LessonTableViewCell
        let model:Model_Chapter = self.dataSource[indexPath.section] as! Model_Chapter
        let Lesson:Model_Lesson = model.Childs[indexPath.row]
        cell.cellforRow(model: Lesson)
        cell.selectionStyle = .none
        cell.islast(islast: model.Childs.count == (indexPath.row+1))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = self.dataSource[section] as! Model_Chapter
        if self.Section.contains(section){
            return model.Childs.count
        }
        return 0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = Bundle.main.loadNibNamed("ChapterTableheaderView", owner: nil, options: nil)?.last as! ChapterTableheaderView
        let model:Model_Chapter = self.dataSource[section] as! Model_Chapter
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
        header.tag = section
        header.addGestureRecognizer(tap)
        header.sectionforModel(model: model)
        header.sectionType(isSelect: self.Section.contains(section))
        return header
        
    }

    
    @objc func tapClick(tap:UITapGestureRecognizer) {
        
        let tag = tap.view?.tag ?? 0
        if self.Section.contains(tag) {
            self.Section.remove(tag)
        }else{
            self.Section.add(tag)
        }

        self.tableView.reloadData()

        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model:Model_Chapter = self.dataSource[indexPath.section] as! Model_Chapter
        let Lesson:Model_Lesson = model.Childs[indexPath.row]
        let vc = VideoViewController(ChapterID: Lesson.ChapterID, SubjectId: Lesson.SubjectID)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ClassRoomChapterViewController{
    override func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: "")
    }
    override func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString()
    }
}

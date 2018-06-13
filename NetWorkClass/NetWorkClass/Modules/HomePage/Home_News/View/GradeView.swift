//
//  GradeView.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/27.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import RxSwift
class GradeAlertView:NSObject {

    static let shared = GradeAlertView()
    let dis = DisposeBag()
    let updata = ViewModel_UpdateStuGrade()
    
    
    var back:UIView = {
        
        let backview = UIView(frame: UIScreen.main.bounds)
        backview.backgroundColor = UIColor.black.alpha(0.5)
        return backview
    }()
    
    var gradeView:GradeView = {
        let grade = Bundle.main.loadNibNamed("GradeView", owner: nil, options: nil)?.last as! GradeView
        grade.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH - 30, height: 300)
        return grade
    }()
    
    private override init() {
        super.init()
        self.gradeView.center = self.back.center
        self.back.addSubview(self.gradeView)
//        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick))
//        self.back.addGestureRecognizer(tap)
        
        self.gradeView.setLayer(cornerRadius: 5, linecolorcolor: UIColor.clear, linewidth: 0, ReacCorner: .all)
        self.gradeView.leftbtn.rx.tap.subscribe { (event) in
            if self.gradeView.leftbtn.title(for: .normal) == "取消"{
                self.tapClick()
            }else if self.gradeView.leftbtn.title(for: .normal) == "上一步"{
                self.gradeView.leftbtn.setTitle("取消", for: .normal)
                self.gradeView.rightbtn.setTitle("下一步", for: .normal)
                self.gradeView.collection.reloadData()

            }
            
        }.disposed(by: dis)
        
        self.gradeView.rightbtn.rx.tap.subscribe { (event) in
            
            if self.gradeView.rightbtn.title(for: .normal) == "下一步"{
                if self.gradeView.GradeID != 10000  {
                    self.gradeView.rightbtn.setTitle("完成", for: .normal)
                    self.gradeView.leftbtn.setTitle("上一步", for: .normal)
                    self.gradeView.getClass()
                }else{

                }

            }else if self.gradeView.rightbtn.title(for: .normal) == "完成"{
                
                self.upadatClass()
                self.tapClick()
            }
            
        }.disposed(by: dis)
        
    }
    
    func upadatClass(){
        
        let out = self.updata.getDataList(classesid: self.gradeView.ClassID)
        out.models.asDriver().drive(onNext: { (issuccess) in
            if issuccess{
                CProgressHUD.showText(text: "修改成功")
            }else{
                CProgressHUD.showText(text: "修改失败")
            }
        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)
        
        out.requestCommond.onNext(true)
    }
    
    func tapClick()  {
        
        self.back.removeFromSuperview()
    }
    
    func show(){

        self.gradeView.leftbtn.setTitle("取消", for: .normal)
        self.gradeView.rightbtn.setTitle("下一步", for: .normal)
        KWindow?.addSubview(back)
        self.gradeView.initData()

    }
    

    
    
}

class GradeView: UIView {

    @IBOutlet weak var leftbtn: UIButton!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var rightbtn: UIButton!
    @IBOutlet weak var collection: UICollectionView!
    
    var GradeID = 10000
    var ClassID = 10000
    
    let dis = DisposeBag()
    let viewmodel = GradeViewModel()
    let classviewmode = ClassViewModel()
    
    var dataSource = NSMutableArray()
    var classData = NSMutableArray()
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        initView()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
    
    override func awakeFromNib() {
        initView()
    }
    func initView(){
        
        self.collection.delegate = self
        self.collection.dataSource = self
        self.collection.register(UINib.init(nibName: "GradeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GradeCollectionViewCell")
        self.collection.emptyDataSetSource = self
        self.collection.emptyDataSetDelegate = self
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: (self.c_w/3 - 50) , height: 50)
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets.init(top: 20, left: 0, bottom: 0, right: 0)
        
        self.collection.collectionViewLayout = layout
        self.leftbtn.setTitle("取消", for: UIControlState.normal)
        self.rightbtn.setTitle("下一步", for: UIControlState.normal)
        

        
    }
    
    func initData() {
        
        let output = self.viewmodel.getDataList()
        output.models.asDriver().drive(onNext: { (models) in
            self.dataSource = NSMutableArray(array: models)
            self.collection.reloadData()
        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)
        
        output.requestCommond.onNext(true)
        
    }
    
    func getClass(){
        let output = self.classviewmode.getDataList(gradeid: self.GradeID)
        output.models.asDriver().drive(onNext: { (models) in
            self.classData = NSMutableArray(array: models)
            self.collection.reloadData()
        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)
        
        output.requestCommond.onNext(true)
    }
    
}

extension GradeView:UICollectionViewDelegate,UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (self.rightbtn.title(for: .normal) == "下一步") {
            return self.dataSource.count
        }
        return self.classData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {


        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GradeCollectionViewCell", for: indexPath) as! GradeCollectionViewCell

        if (self.rightbtn.title(for: .normal) == "下一步") {
            let model = self.dataSource[indexPath.item] as! Model_Grade
            cell.cellforModel(model: model)
            cell.SelectCell(isSelect: self.GradeID == model.GradeID)
        }else if(self.rightbtn.title(for: .normal) == "完成"){
            let model = self.classData[indexPath.item] as! Model_Class
            cell.cellforClass(model: model)
            cell.SelectCell(isSelect: self.ClassID == model.ClassesID)

        }
        
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (self.rightbtn.title(for: .normal) == "下一步") {
            let model = self.dataSource[indexPath.item] as! Model_Grade
            self.GradeID = model.GradeID
        }else if(self.rightbtn.title(for: .normal) == "完成"){
            let model = self.classData[indexPath.item] as! Model_Class
            self.ClassID = model.ClassesID
        }
        collectionView.reloadData()
    }

}
import DZNEmptyDataSet

extension GradeView:DZNEmptyDataSetSource,DZNEmptyDataSetDelegate{
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        
        return #imageLiteral(resourceName: "暂无数据")
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        
        let dict = [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14)]
        
        return NSAttributedString(string: "暂无数据", attributes: dict)
    }
}


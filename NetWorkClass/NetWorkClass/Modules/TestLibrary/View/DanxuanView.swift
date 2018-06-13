//
//  DanxuanView.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/28.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import RxSwift
class DanxuanView: UIView {
    
    @IBOutlet weak var tableView_h: NSLayoutConstraint!
    @IBOutlet weak var ImageHeight: NSLayoutConstraint!
    @IBOutlet weak var SubjectInfo: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var image: UIImageView!
    
    var selectArr = NSMutableArray()

    fileprivate var type:TextType = .Danxuan
    var model : Model_Danxuan?
    
    let viewmodel = HandExerciseManager()
    let dis = DisposeBag()
    var Myselect:[Int:[Int]] = [:]
    var isBianHua = 0
    var defen = 0
    
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.tableView.register(UINib.init(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: "OptionTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.isScrollEnabled = false
        self.tableView.separatorStyle = .none
        
        
    }
    

    
    func getData(model:Model_Danxuan) {
        
        self.selectArr.removeAllObjects()
        self.model = model
        self.type = self.model!.FixedType.typeforTextType()
        self.isBianHua = 0

//        self.title.text = model.TypeName
        self.SubjectInfo.text = model.Stem.removingPercentEncoding
        self.image.c_setImage(url: model.StemImg)
        if model.StemImg == "" {
            self.ImageHeight.constant = 0
        }else{
            self.ImageHeight.constant = 70
        }
        self.defen = 0

        if self.Myselect[model.QuestionID] == nil {
            var arr:[Int] = []
            for model in model.ExamDetails {
                arr.append(Int(model.QuestionBodyID) ?? 0)
            }
            self.Myselect[model.QuestionID] = arr
        }

        ///控制ScrollView的大小,调整位置
        var h:CGFloat = 0
        for model in self.model!.QuestionBody {
            let value = model.OptionValue
            h = h + (value.autoLabelHeight(with: SCREEN_WIDTH - 80, font: 14) + 20)
            
        }
        
        self.tableView_h.constant = h + 50
        
        self.tableView.reloadData()

    }
    
    func tijiao(){
        
        if self.isBianHua == 0 {
            return
        }
        if self.model == nil{
            return
        }

        var questionbodyid = ""
        for question in self.Myselect[model!.QuestionID]! {
            
            questionbodyid = questionbodyid + question.string()
        }
        
 
        let output = self.viewmodel.getDataList(exambodyid: model!.ExamBodyID, questionbodyid: questionbodyid, contentaddress: "[]", score: model!.Score, studentid: KUserInfo.user.StudentID)
        output.models.asDriver().drive(onNext: { (models) in
            
        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)
        
        output.requestCommond.onNext(true)


    }
    

}

extension DanxuanView:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionTableViewCell", for: indexPath) as! OptionTableViewCell
        let model = self.model?.QuestionBody[indexPath.row]
        if model != nil {
            cell.cellforModel(model: model!)
        }
        cell.selectionStyle = .none
        cell.xuanxiang.setTitle(indexPath.row.ABCD(), for: .normal)
        
        if Myselect.keys.contains(self.model!.QuestionID) {
            
            if let arr = Myselect[self.model!.QuestionID]{
                
                if arr.contains(model?.QuestionBodyID ?? -1){
                    cell.xuanxiang.backgroundColor = TINTCOLOR
                    cell.xuanxiang.setTitleColor(WHITEColor, for: .normal)
                }else{
                    cell.xuanxiang.backgroundColor = WHITEColor
                    cell.xuanxiang.setTitleColor(UIColor.black, for: .normal)
                }
            }

        }else{
            cell.xuanxiang.backgroundColor = WHITEColor
            cell.xuanxiang.setTitleColor(UIColor.black, for: .normal)
        }
        

        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.QuestionBody.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = self.model?.QuestionBody[indexPath.row]
        let value = model?.OptionValue ?? ""
        return value.autoLabelHeight(with: SCREEN_WIDTH - 80, font: 14) + 20
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.model?.QuestionBody[indexPath.row]

        switch self.type {
        case .Danxuan,.Panduan:
            self.selectArr.removeAllObjects()
            self.selectArr.add(model?.QuestionBodyID)
            if model?.IsRight == 1{
                self.defen = self.model?.Score ?? 0
            }
        case .Duoxuan:
            if self.selectArr.contains(model?.QuestionBodyID){
                self.selectArr.remove(model?.QuestionBodyID)
            }else{
                self.selectArr.add(model?.QuestionBodyID)
            }
            var right:[Int] = []
            
            for m in self.model?.QuestionBody ?? []{
                if m.IsRight == 1{
                    right.append(m.QuestionBodyID)
                }
            }
            let my = self.selectArr as! [Int]
            if my == right{
                self.defen = self.model?.Score ?? 0
            }
        default:
            break
            
        }
        self.Myselect[self.model!.QuestionID] = self.selectArr as? [Int]

        self.isBianHua = 1
        self.tableView.reloadData()
        
        
    }
    
}

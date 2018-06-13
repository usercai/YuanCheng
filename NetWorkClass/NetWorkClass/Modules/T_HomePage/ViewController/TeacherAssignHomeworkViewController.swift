//
//  TeacherAssignHomeworkViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/21.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class TeacherAssignHomeworkViewController: BaseViewController {

    private var homework:UITextView = UITextView()
    private var collection:CCollectionView? = nil
    private var model:Model_GradeSubject? = nil
    private var homeworkmodel:Model_HomeWork? = nil
    private var time = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "布置作业"
        // Do any additional setup after loading the view.
    }

    convenience init(model:Model_GradeSubject,time:String) {
        self.init()
        self.model = model
        self.time = time
    }
    
    /// 修改作业
    ///
    /// - Parameters:
    ///   - model: Model_homework
    ///   - time: 时间
    convenience init(homemodel:Model_HomeWork,time:String,model:Model_GradeSubject) {
        self.init()
        self.homeworkmodel = homemodel
        self.time = time
        self.model = model
    }
    override func initView() {
        
        self.homework.frame = CGRect.init(x: 20, y: 20, width: SCREEN_WIDTH - 40, height: 100)
        self.homework.font = CFont_14
        self.homework.textColor = TextColor
        self.homework.setC_placeHolerLabel(hc_placeHolerLabel: "请填写作业描述...")
        self.view.addSubview(self.homework)
        
        self.collection = CCollectionView(frame: CGRect.init(x: 0, y: self.homework.c_maxY(), width: SCREEN_WIDTH, height: 70))
        self.collection?.imagePicker?.imageLimit = 1
        self.view.addSubview(self.collection!)
        
        let item = UIBarButtonItem(title: "提交", style: UIBarButtonItemStyle.plain, target: self, action: #selector(tijiao))
        
        self.navigationItem.setRightBarButton(item, animated: true)
        
        if self.homeworkmodel != nil {
            
            self.homework.text = self.homeworkmodel?.HomeworkTitle.urlDecoded()
            if !self.homeworkmodel!.HomeworkImg.C_isEmpty(){
                self.collection?.setDataSource(urls: [self.homeworkmodel!.HomeworkImg])
            }
            
        }
        
    }
    
    @objc func tijiao()  {
        
        if self.model == nil {
            return
        }
        if self.homework.text.count == 0 {
            CProgressHUD.showText(text: "请填写作业信息")
            return
        }
        if self.collection?.dataSource.count != 0 {
            let upload = UpLoadViewModel()
            let out = upload.uploadImage(fileArr: (self.collection?.dataSource)!, name: "jpg", fileAddress: .HomeworkImg)
            out.models.asDriver().drive(onNext: { (models) in
                if models.count == self.collection?.dataSource.count{

                    self.dataSource = NSMutableArray(array: models)
                    self.subdata()
                }
            }, onCompleted: nil, onDisposed: nil).disposed(by: dis)
        }else{
            
            self.subdata()
        }
        
        
    }
    
    func subdata() {
        var path = ""
        if self.dataSource.count == 0 {
            path = self.homeworkmodel?.HomeworkImg ?? ""
        }else{
            let model = self.dataSource.firstObject as! Model_Path
            path = model.path

        }
        let homeworkid = self.homeworkmodel?.HomeworkID ?? 0
        
        CProgressHUD.showLoading()
        T_HomePageTool.rx.request(T_HomePageAPI.AssignHomework( homeworkid ,self.model!.SchoolYearID, self.model!.SubjectID, "", time, self.homework.text!, path)).subscribe(onSuccess: { (res) in
            res.C_mapjson(success: { (dic) in
                NotificationCenter.default.post(name: NSNotification.Name.init("nowDate"), object: nil, userInfo: ["date" : Date(),"role":KUserInfo.UserRole])
                self.navigationController?.popViewController(animated: true)
                CProgressHUD.showText(text: "提交成功")
            }, falue: { (code, msg) in

                
            })
        }) { (error) in

            
        }.disposed(by: dis)
        

    }
}

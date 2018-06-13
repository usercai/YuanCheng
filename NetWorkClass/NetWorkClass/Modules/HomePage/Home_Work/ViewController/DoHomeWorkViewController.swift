//
//  DoHomeWorkViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/1.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import ImagePicker

class DoHomeWorkViewController: BaseViewController {
    enum type {
        case edit
        case finish
    }
    
    
    @IBOutlet weak var homeworkiamge_h: NSLayoutConstraint!
    @IBOutlet weak var homwworktitle: UILabel!
    @IBOutlet weak var homework: UITextView!
    @IBOutlet weak var homeworkimage: UIImageView!
    let viewmodel = UpLoadViewModel()
    var imageArray:[Model_Path] = []
    let imageviewmodel = DoHomeWorkViewModel()
    
    @IBOutlet weak var homework_h: NSLayoutConstraint!
    @IBOutlet weak var homeworkview: UIView!

    var homeworkid = 0
    var homeworkbodyid = 0
    private var collection:CCollectionView? = nil
    private var model:Model_DoHomeWork? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "上传作业"
    }

    override func initData() {
        homePageTool.rx.request(HomePageApi.SelectHomeWork(self.homeworkid)).asObservable().mapArray(Model_DoHomeWork.self).subscribe(onNext: { (models) in
            if models.count != 0{
                self.model = models.first
                self.updateView()
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: dis)
        
    }
    
    override func initView(){
        
        let item1 = UIBarButtonItem(title: "完成", style: UIBarButtonItemStyle.done, target: self, action: #selector(wancheng))
        self.navigationItem.rightBarButtonItems = [item1]
        self.homework.isEditable = false
        
        self.collection = CCollectionView(frame: CGRect.init(x: 0, y: self.homeworkview.c_maxY(), width: SCREEN_WIDTH, height: 70))
        self.view.addSubview(self.collection!)
        
        let ges = UITapGestureRecognizer(target: self, action: #selector(big))
        self.homeworkimage.isUserInteractionEnabled = true
        self.homeworkimage.addGestureRecognizer(ges)
        
    }
    //更新空间跟位置
    func updateView() {
    
        guard let homeworkmodel = self.model?.homework.first else {
            return
        }

        
        self.homework.text = homeworkmodel.HomeworkTitle.urlDecoded()
        let size = self.homework.sizeThatFits(CGSize.init(width: SCREEN_WIDTH, height: 200))
        self.homework_h.constant = size.height + 15
        if homeworkmodel.HomeworkImg.count == 0 {
            self.homeworkiamge_h.constant = 0
        }else{
            self.homeworkiamge_h.constant = 70
            self.homeworkimage.c_setImage(url: (homeworkmodel.HomeworkImg))
        }

        let y = self.homework_h.constant + self.homeworkiamge_h.constant + 100
        self.collection?.frame = CGRect.init(x: 0, y: y, width: SCREEN_WIDTH, height: 70)

        if let bodymodel = self.model?.homeworkbody.first {
            var arr:[String] = []
            if bodymodel.HomeworkFiles.count != 0{
                for model in bodymodel.HomeworkFiles{
                    arr.append(model.ContentAddress)
                }
                self.collection?.setDataSource(urls: arr)
            }
            
        }

    }
    
    @objc func big() {
        CImageViewer.shared.showViewer(images: [self.homeworkimage])
    }
    convenience init(homeworkid:Int) {
        self.init()
        self.homeworkid = homeworkid

    }
    @objc func wancheng() {
        
        var arr:[String] = []
        
        for image in self.collection!.dataSource {
            
            arr.append(image.base64().utf8encodedString())
        }
        
        let out = self.viewmodel.upLoad(fileArr: arr, name: "jpg", fileAddress: .HomeworkImg)
        out.models.asDriver().drive(onNext: { (models) in
            if models.count == self.collection!.dataSource.count{

                self.imageArray = models
                
                self.submitData()

            }
        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)
        
    }
    
    func submitData(){
        

        self.imageviewmodel.getDataList(homeworkid: self.homeworkid, homeworkbodyid: self.model?.homeworkbody.first?.HomeworkBodyID ?? 0, jsonHomeworkFiles: self.imageArray.ImageArrtoString()).skipWhile({
            $0 == true
        }).subscribe(onNext: { (issuccess) in
            //发推送
            PushManager.share.push(type: PushType.Zuoye, PushID: self.homeworkid, receiveid: 0)
            AppTool.currentViewController()?.navigationController?.popViewController(animated: true)
        }, onError: { (error) in
            
        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)

    }
    
    
}




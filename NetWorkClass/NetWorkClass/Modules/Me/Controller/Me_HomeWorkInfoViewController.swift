//
//  Me_HomeWorkInfoViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/12.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit


class Me_HomeWorkInfoViewController: BaseViewController {

    
    
    @IBOutlet weak var homeworkView_h: NSLayoutConstraint!
    @IBOutlet weak var myqustion_h: NSLayoutConstraint!
    @IBOutlet weak var homeworkImage_h: NSLayoutConstraint!
    @IBOutlet weak var homework_h: NSLayoutConstraint!
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var collectionView: UIView!
    @IBOutlet weak var homeworkImage: UIImageView!
    @IBOutlet weak var homeinfo: UITextView!
    @IBOutlet weak var pingyu: UITextView!
    var model:Model_HomeWorkInfo?
    var collection:CShowCollectionView? = nil
    
    var HomeWorkId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "作业记录"
        
        // Do any additional setup after loading the view.
    }

    override func initView() {
        self.collection = CShowCollectionView(frame: self.collectionView.bounds)
        self.collection?.backgroundColor = BackBlueColor
        self.collection?.collectionView.backgroundColor = BackBlueColor
        self.collectionView.addSubview(self.collection!)

        self.homeworkImage.contentMode = .scaleAspectFill
        self.homeworkImage.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick))
        self.homeworkImage.addGestureRecognizer(tap)
        
        self.homeinfo.isEditable = false
        self.pingyu.setC_placeHolerLabel(hc_placeHolerLabel: "暂无评语...")

    }
    
    @objc func tapClick(){

        CImageViewer.shared.showViewer(images: [self.homeworkImage])
    }
    
    convenience init(HomeWorkId:Int) {
        self.init()
        self.HomeWorkId = HomeWorkId
    }
    override func initData() {
        
        MeTool.rx.request(MeApi.QueryHomeWorkById(self.HomeWorkId)).asObservable().mapArray(Model_HomeWorkInfo.self).subscribe(onNext: { (models) in
            if models.count != 0{
                self.model = models.first
                self.initDataView()
            }
        }, onError: { (error) in
            CProgressHUD.showError(error: "请求失败")
        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)
    }
    
    func initDataView() {
        self.time.text = self.model?.CreateDataTime.timeString()
        self.homeinfo.text = self.model?.HomeworkTitle
        self.pingyu.text = self.model?.Comment

        
        guard let childs = self.model?.childs else {
            return
        }
        var arr:[String] = []
        for model in childs {
            arr.append(model.ContentAddress)
        }
        self.collection?.setDataSource(images: arr)
        
        
        let size = self.homeinfo.sizeThatFits(CGSize.init(width: SCREEN_WIDTH - 40, height: 300))
        self.homework_h.constant = size.height + 20
        if self.model?.HomeWorkImg.count == 0{
            self.homeworkImage_h.constant = 0
        }else{
            self.homeworkImage.c_setImage(url: self.model?.HomeWorkImg ?? "")

            self.homeworkImage_h.constant = 70
        }
        self.homeworkView_h.constant = self.homeworkImage_h.constant + self.homework_h.constant + 150
    }
    
    

}

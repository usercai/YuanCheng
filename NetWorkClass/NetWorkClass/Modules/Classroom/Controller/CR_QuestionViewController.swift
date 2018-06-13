

//
//  CR_QuestionViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/29.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import Moya
class CR_QuestionViewController: BaseViewController {

    var videoId = 0
    var subjectId = 0
    var chapterId = 0
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var textview: UITextView!
    @IBOutlet weak var tijao: UIButton!
    
    @IBOutlet weak var quxiao: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "提问"
        self.backView.setLayerForNormal(cornerRadius: 0, linecolorcolor: TINTCOLOR, linewidth: 1)
        self.textview.setC_placeHolerLabel(hc_placeHolerLabel: "请输入你想要提问的问题...")
        self.tijao.setLayerForNormal(cornerRadius: 3)
        self.quxiao.setLayerForNormal(cornerRadius: 3)
        // Do any additional setup after loading the view.
    }
    convenience init(videoId:Int,subjectId:Int,chapterId:Int) {
        self.init()
        self.videoId = videoId
        self.subjectId = subjectId
        self.chapterId = chapterId
    }
    override func initView() {
        if iPhone5S {
            self.scrollView.isScrollEnabled = true
        }
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func quxiao(_ sender: UIButton) {
        

    }
    
    @IBAction func tijiao(_ sender: UIButton) {
        //1-视频  5-章节
        var typeid = 1
        
        if self.textview.text.count == 0 {
            CProgressHUD.showText(text: "请输入问题内容")
            return
        }
        if self.videoId == 0{
            typeid = 5
        }
        CProgressHUD.showLoading()
        
        
        ClassRoomTool.rx.request(ClassRoomApi.SubmitAsk(self.textview.text, self.videoId, self.chapterId, self.subjectId, typeid)).subscribe(onSuccess: { (response) in
            response.C_mapjson(success: { (dict) in

                self.push(dic: dict)
                self.textview.text = ""
                CProgressHUD.showText(text: "成功")
            }, falue: { (code, msg) in
                CProgressHUD.showText(text: msg)
            })
        }) { (error) in
            CProgressHUD.showText(text: "请求错误")
            }.disposed(by: dis)
        
    }
    
    func push(dic:Dictionary<String, Any>)  {
        var teacherid = 0
        var answerid = 0
        
        if dic.keys.contains("TeacherID") {
            teacherid = dic["TeacherID"] as! Int
            
        }
        
        if dic.keys.contains("AnswerID") {
            answerid = dic["AnswerID"] as! Int
        }
        
        PushManager.share.push(type: PushType.TiWen, PushID: answerid, receiveid: teacherid)
    }
    

}

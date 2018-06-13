//
//  TL_TestPaperInfoViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/28.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

//模拟题
class TL_TestPaperInfoViewController: BaseViewController {

    var index = 0
    var count = 0
    
    /// 模拟题试题
    let viewmodel = TL_TestPaperInfoViewModel()
    var examID = 0
    var Danxuan:DanxuanView?
    var tinakong:TiankongView?
    var dict:[String:Model_Danxuan] = [:]
    var TitleLabel:UILabel = {
        let label = UILabel()
        return label
    }()
    
    let numlabel : UILabel = {
        let num = UILabel()
        return num
    }()

    
   
    convenience init(examID:Int,Count:Int) {
        self.init()
        self.examID = examID
        self.count = Count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTitleView()
        // Do any additional setup after loading the view.
    }
    
    override func initData() {
        let output = self.viewmodel.getDataList(examID: self.examID, index: self.index)
        output.models.asDriver().drive(onNext: { (models) in
            if models.count != 0{
                self.dict[self.index.string()] = models.first!
                self.viewForModel(model: models.first!)
            }

        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)

        output.requestCommond.onNext(.first)

    }
    
    
    override func initView() {
        
    
        let leftswip = UISwipeGestureRecognizer(target: self, action: #selector(swipClick))
        leftswip.direction = UISwipeGestureRecognizerDirection.right
        let rightswip = UISwipeGestureRecognizer(target: self, action: #selector(swipClick))
        rightswip.direction = UISwipeGestureRecognizerDirection.left
        self.view?.addGestureRecognizer(leftswip)
        self.view?.addGestureRecognizer(rightswip)
        
        let btn = UIButton(frame: CGRect.init(x: 0, y: 0, width: 45, height: 22.5))
        btn.setLayerForNormal(cornerRadius: 5, linecolorcolor: WHITEColor, linewidth: 1)
        btn.setTitle("交卷", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.rx.tap.subscribe { (event) in
            //提交刚才做的题的数据
            if self.dict.keys.contains(self.index.string()) == true{
                let model = self.dict[self.index.string()]
                switch model!.FixedType.typeforTextType() {
                case .Danxuan,.Duoxuan,.Panduan:
                    self.Danxuan?.tijiao()
                default:
                    self.tinakong?.tijiao()
                    
                }
            }

            AppTool.showAlert(title: "确定交卷吗?", QAction: {
                TestLibraryTool.rx.request(TestLibraryApi.SubmitAllQuestion(self.examID, KUserInfo.UserID())).subscribe(onSuccess: { (res) in
                    res.C_mapjson(success: { (dic) in
                        PushManager.share.push(type: PushType.Kaoshi, PushID: self.examID, receiveid: 0)
                        CProgressHUD.showText(text: "交卷成功")
                        self.navigationController?.popViewController(animated: true)
                        
                    }, falue: { (code, msg) in
                        
                    })
                }) { (err) in
                    
                    }.disposed(by: self.dis)
            })

        }.disposed(by: dis)
        let barbtn = UIBarButtonItem(customView: btn)
        self.navigationItem.rightBarButtonItem = barbtn
    }
    
    func initTitleView(){
        
        self.TitleLabel.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 40)
        self.TitleLabel.font = UIFont.systemFont(ofSize: 14)
        self.TitleLabel.textColor = TextColor
        self.TitleLabel.textAlignment = .center
        self.view.addSubview(self.TitleLabel)
        
        self.numlabel.frame = CGRect(x: SCREEN_WIDTH - 50, y: 0, width: 50, height: 40)
        self.numlabel.textAlignment = .left
        self.numlabel.font = UIFont.systemFont(ofSize: 12)
        self.numlabel.textColor = TextColor999999
        self.view.addSubview(self.numlabel)
        
        
        self.Danxuan = Bundle.main.loadNibNamed("DanxuanView", owner: nil, options: nil)?.first as? DanxuanView
        Danxuan?.frame = CGRect(x: 0, y: self.TitleLabel.c_maxY(), width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 40 - TabStateBarHeight)
        Danxuan?.isHidden = true
        self.view.addSubview(Danxuan!)
        
        self.tinakong = TiankongView(frame: CGRect(x: 0, y: self.TitleLabel.c_h, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 40 - TabStateBarHeight))
        self.tinakong?.isHidden = true
        self.view.addSubview(self.tinakong!)
        
    }

    
    @objc func swipClick(swip:UISwipeGestureRecognizer) {

        //提交刚才做的题的数据
        if self.dict.keys.contains(self.index.string()) == true{
            let model = self.dict[self.index.string()]
            switch model!.FixedType.typeforTextType() {
            case .Danxuan,.Duoxuan,.Panduan:
                self.Danxuan?.tijiao()
            default:
                self.tinakong?.tijiao()

            }
        }

        
        //翻页并且获取上一题或者下一题的数据
        if swip.direction == UISwipeGestureRecognizerDirection.right{
            
            let index = self.index - 1
            if index < 0{
                return
            }

            self.index = index
            leftani()
        }
        if swip.direction == UISwipeGestureRecognizerDirection.left{

            let index = self.index + 1
            
            if index >= self.count{
                return
            }
            
            self.index = index
            rightani()
            

        }

        if self.dict.keys.contains(self.index.string()) == true{
            
            viewForModel(model: self.dict[self.index.string()]!)
        }else{
            self.initData()
        }
        
        
    }
    func viewForModel(model:Model_Danxuan){
        
        switch model.FixedType.typeforTextType() {
        case .Danxuan,.Duoxuan,.Panduan:
            self.Danxuan?.isHidden = false
            self.tinakong?.isHidden = true
            self.Danxuan?.getData(model: model)
        default:
            self.tinakong?.isHidden = false
            self.Danxuan?.isHidden = true
            self.tinakong?.setData(model: model)
        }

        self.TitleLabel.text = model.TypeName
        self.numlabel.text = (self.index + 1).string() + "/" + self.count.string()
        
    }
    
    func leftani() {
        let ani = CATransition.init()
        ani.duration = 0.7
        ani.type = "pageCurl"
        ani.subtype = kCATransitionFromLeft
        ani.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)
        self.view.layer.add(ani, forKey: "leftanimation")
    }
    
    func rightani(){
        let ani = CATransition.init()
        ani.duration = 0.7
        ani.type = "pageCurl"
        ani.subtype = kCATransitionFromRight
        ani.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)
        self.view.layer.add(ani, forKey: "rightanimation")
    }

}


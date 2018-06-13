//
//  TL_ExercisesPageViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/6.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

/// 练习题
class TL_ExercisesPageViewController: BaseViewController {

    var titleView : ExercisesNumView? = nil
    var contentView:UIView? = nil
    var Danxuan:LX_DanxuanView?
    var tinakong:LX_TiankongView?
    let viewmodel = TL_ExercisesInfoViewModel()
    var typeId = 0
    var gId = 0
    var sId = 0
    var pageIndex = 1
    var pageSize = 10
    var index = 0
    var count = 0
    var scrollView:UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    
    
    var TitleLabel:UILabel = {
        let label = UILabel()
        return label
    }()
    
    let numlabel : UILabel = {
        let num = UILabel()
        return num
    }()
    
    var MySelect:[Int:[Int]] = [:]
    
    
    
    var dicSource:[String:[Model_Danxuan]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initGesture()
        // Do any additional setup after loading the view.
    }
    
    convenience init(typeId:Int,gid:Int,sId:Int,count:Int) {
        self.init()
        self.typeId = typeId
        self.gId = gid
        self.sId = sId
        self.count = count
    }

    override func initView() {
        
        self.titleView = ExercisesNumView(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 30), Count: self.count)
        
        self.titleView?.didSelectItem = {
            index in
            
            if self.pageIndex == index + 1{
                return
            }
            
            self.pageIndex = index + 1
            self.index = index*10
            if self.dicSource.keys.contains((index+1).string()) == true{
                
                self.viewForModel()
            }else{
                
                self.initData()
            }
        }
        
        self.view.addSubview(self.titleView!)
        
        
        self.contentView = UIView(frame: CGRect.init(x: 0, y: self.titleView!.c_maxY(), width: SCREEN_WIDTH, height: SCREEN_HEIGHT - NaviBarHeight - 30 - TabStateBarHeight))
        self.contentView?.backgroundColor = WHITEColor
        self.view.addSubview(self.contentView!)
        
        self.TitleLabel.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 40)
        self.TitleLabel.font = UIFont.systemFont(ofSize: 14)
        self.TitleLabel.textColor = TextColor
        self.TitleLabel.textAlignment = .center
        self.contentView!.addSubview(self.TitleLabel)
        
        self.numlabel.frame = CGRect(x: SCREEN_WIDTH - 50, y: 0, width: 50, height: 40)
        self.numlabel.textAlignment = .left
        self.numlabel.font = UIFont.systemFont(ofSize: 12)
        self.numlabel.textColor = TextColor999999
        self.contentView!.addSubview(self.numlabel)
        
        self.Danxuan = Bundle.main.loadNibNamed("LX_DanxuanView", owner: nil, options: nil)?.first as? LX_DanxuanView
        Danxuan?.frame = CGRect(x: 0, y: self.numlabel.c_maxY(), width: SCREEN_WIDTH, height: self.contentView!.c_h - 40)
        Danxuan?.isHidden = true
        let swip = UISwipeGestureRecognizer()
        swip.direction = UISwipeGestureRecognizerDirection.left
        //选择是否正确.仅限单选,正确跳下一页
        Danxuan?.Right.asObservable().subscribe(onNext: { (right) in
            if right == true{

                self.swipClick(swip: swip)
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: dis)
        //记录选择的题目
        Danxuan?.MySelect.asObservable().subscribe(onNext: { (myselect) in
            self.MySelect[self.index] = myselect
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: dis)

        
        self.contentView!.addSubview(Danxuan!)
        
        self.tinakong = LX_TiankongView(frame: CGRect(x: 0, y: self.numlabel.c_maxY(), width: SCREEN_WIDTH, height: self.contentView!.c_h - 40))
        self.tinakong?.isHidden = true
        self.contentView!.addSubview(self.tinakong!)
        
        
        
    }

    override func initData() {
        
        let output = self.viewmodel.getDataList(typeId: self.typeId, pageIndex: self.pageIndex, pageSize: self.pageSize, sId: self.sId, gId: self.gId)
        output.models.asDriver().drive(onNext: { (models) in
            self.dicSource[self.pageIndex.string()] = models
            self.viewForModel()
        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)
        
        
        output.requestCommond.onNext(true)

    }
    
    
    
    func viewForModel() {
        
        if self.dicSource.keys.contains(self.pageIndex.string()) == false{
            
            return
        }
        
        let models = self.dicSource[self.pageIndex.string()]
        if models?.count == 0 {
            return
        }
        
        let indexItem = self.index%10
        
        let model = models![indexItem]
        
        switch model.FixedType.typeforTextType() {
        case .Danxuan, .Duoxuan, .Panduan:
            self.Danxuan?.isHidden = false
            self.tinakong?.isHidden = true
            
            self.Danxuan?.getData(model: model, SelectIndex: self.MySelect[self.index] ?? [-1])
        default:
            self.tinakong?.isHidden = false
            self.Danxuan?.isHidden = true
            self.tinakong?.setData(model: model)
        }

        

        self.TitleLabel.text = model.TypeName
        self.numlabel.text = (self.index + 1).string() + "/" + self.count.string()
        
        
    }
    
    
}


extension TL_ExercisesPageViewController{
    func initGesture(){
        let leftswip = UISwipeGestureRecognizer(target: self, action: #selector(swipClick))
        leftswip.direction = UISwipeGestureRecognizerDirection.right
        let rightswip = UISwipeGestureRecognizer(target: self, action: #selector(swipClick))
        rightswip.direction = UISwipeGestureRecognizerDirection.left
        self.contentView?.addGestureRecognizer(leftswip)
        self.contentView?.addGestureRecognizer(rightswip)
    }
    
    @objc func swipClick(swip:UISwipeGestureRecognizer) {
        
        self.Danxuan?.showJiexi.value = false
        if swip.direction == UISwipeGestureRecognizerDirection.right{
            
            let index = self.index - 1
            if index < 0{
                return
            }
            
            self.index = index
            if self.pageIndex != Int(index/10) + 1{
                
                self.titleView?.setSelectItem(item: Int(index/10))
            }
            self.pageIndex = Int(index/10) + 1
            
            leftani()
        }
        
        if swip.direction == UISwipeGestureRecognizerDirection.left{
            
            let index = self.index + 1
            
            if index >= self.count{
                return
            }
            
            self.index = index
            
            //翻到了10页 index = 9 self.pageindex = 1   1
            //11页 index = 10 self.pageindex = 1 2
            if self.pageIndex != Int(index/10) + 1{
                
                self.titleView?.setSelectItem(item: Int(index/10))
            }
            
            self.pageIndex = Int(index/10) + 1
            rightani()
        }
        
        if self.dicSource.keys.contains(self.pageIndex.string()) == true{
            viewForModel()
        }else{
            self.initData()
        }
        
    }
    
    func leftani() {
        let ani = CATransition.init()
        ani.duration = 0.7
        ani.type = "pageCurl"
        ani.subtype = kCATransitionFromLeft
        ani.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)
        self.contentView!.layer.add(ani, forKey: "leftanimation")
    }
    
    func rightani(){
        let ani = CATransition.init()
        ani.duration = 0.7
        ani.type = "pageCurl"
        ani.subtype = kCATransitionFromRight
        ani.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)
        self.contentView!.layer.add(ani, forKey: "rightanimation")
    }
}




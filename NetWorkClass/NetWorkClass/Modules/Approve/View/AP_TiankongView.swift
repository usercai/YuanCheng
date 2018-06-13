//
//  TiankongView.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/5.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import RxSwift
class AP_TiankongView: UIView {
    
    var textview : UITextView? = nil
    var image : UIImageView? = nil
    var jiexiView:UITextView = UITextView()
    var jiexiButton:UIButton = UIButton()
    let dis = DisposeBag()
    var defen:UITextField = {
        let defen = UITextField()
        return defen
    }()
    var collection : CShowCollectionView? = nil
    var showjiexi = false
    var tijiao:UIButton = {
        let btn = UIButton()
        btn.backgroundColor = TINTCOLOR
        btn.setTitle("提交", for: .normal)
        btn.setLayerForNormal(cornerRadius: 5)
        btn.titleLabel?.font = CFont_14
        return btn
    }()
    private var model:Model_DanxuanJiLu? = nil
    
    private var questionView:UIView = {
        let view = UIView()
        view.backgroundColor = BackBlueColor
        return view
    }()
    private var answerView:UIView = {
        let view = UIView()
        view.backgroundColor = WHITEColor
        return view
    }()
    public var dafen:Variable<Int> = Variable<Int>(0)
    private var jiexi:UILabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView()  {
        self.backgroundColor = WHITEColor
        //问题View
        self.questionView.frame = CGRect(x: 0, y: 0, width: self.c_w, height: 280)
        self.addSubview(self.questionView)
        //题干
        self.textview = UITextView(frame: .init(x: 0, y: 0, width: SCREEN_WIDTH, height: 100))
        self.textview?.isEditable = false
        self.textview?.backgroundColor = BackBlueColor
        self.textview?.textColor = TextColor
        self.questionView.addSubview(self.textview!)
        //题干图片
        self.image = UIImageView(frame: CGRect.init(x: 20, y: self.textview!.c_maxY(), width: 80, height: 80))
        self.image?.clipsToBounds = true
        self.image?.contentMode = .scaleAspectFill
        self.image?.isUserInteractionEnabled = true
//        self.image?.setLayerForNormal(cornerRadius: 5, linecolorcolor: TINTCOLOR, linewidth: 1)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick))
        self.image?.addGestureRecognizer(tap)

        
        self.questionView.addSubview(self.image!)
        //学生解答
        self.collection = CShowCollectionView(frame: CGRect.init(x: 0, y: self.image!.c_maxY(), width: self.frame.width, height: 100))
        self.collection?.collectionView.backgroundColor = BackBlueColor
        self.questionView.addSubview(self.collection!)

        
        
        //老师解答View
        self.jiexi = UILabel(frame: CGRect(x: 15, y: self.questionView.c_maxY(), width: 40, height: 30))
        self.jiexi.textColor = UIColor.red
        self.jiexi.font = CFont_14
        self.jiexi.text = "解析"
        self.addSubview(self.jiexi)
        
        self.defen.frame = CGRect.init(x: self.jiexi.c_maxX(), y: self.jiexi.c_y, width: SCREEN_WIDTH, height: 30)
        self.defen.placeholder = "得分"
        self.defen.textColor = UIColor.red
        self.defen.font = CFont_14
        self.defen.borderStyle = .none
        self.addSubview(self.defen)
        
        
        
        self.jiexiView.frame = CGRect.init(x: 15, y: self.defen.c_maxY(), width: self.c_w - 30, height: 150)
        self.jiexiView.isEditable = false
        self.jiexiView.backgroundColor = WHITEColor
        
        self.addSubview(self.jiexiView)
        
        self.tijiao.frame = CGRect.init(x: 20, y: self.jiexiView.c_maxY(), width: self.c_w - 40, height: 35)
        
        ///提交得分
        self.tijiao.rx.tap.asObservable().subscribe { (event) in
            self.dafen.value = 0
            if self.model?.ExamDetailsID == 0{
                return
            }
            if self.model == nil{
                return
            }
            if self.defen.text?.count == 0{
                CProgressHUD.showText(text: "别忘记打分哦")
                return
            }
            guard let defen = Int(self.defen.text!) else{
                return
            }

            if defen > self.model?.Score ?? 0{
                CProgressHUD.showText(text: "不能大于最大分")
                return
            }
            
            ApproveTool.rx.request(ApproveApi.ReviewDetailesData(self.model!.ExamDetailsID, defen , 1)).asObservable().subscribe(onNext: { (res) in
                res.C_mapjson(success: { (dic) in
                    CProgressHUD.showText(text: "打分成功")

                }, falue: { (code, msg) in
                    
                })
            }, onError: { (error) in
                
            }, onCompleted: nil, onDisposed: nil).disposed(by: self.dis)
        }.disposed(by: dis)
        self.addSubview(self.tijiao)
    }
    @objc func tapClick() {
        CImageViewer.shared.showViewer(images: [self.image!])
    }
    /// 更新Frame
    func upDataFrame(){

        let sizeHeight = self.textview?.sizeThatFits(CGSize(width: self.c_w, height: 200)).height
        self.textview?.c_setHeight(height: sizeHeight!)
        if self.model!.StemImg == "" {
            self.image?.frame = CGRect.init(x: 20, y: self.textview!.c_maxY(), width: 80, height: 0)
        }else{
            self.image?.frame = CGRect.init(x: 20, y: self.textview!.c_maxY(), width: 80, height: 80)
        }
        self.collection?.frame =  CGRect.init(x: 0, y: self.image!.c_maxY(), width: self.frame.width, height: 100)
        self.questionView.frame = CGRect(x: 0, y: 0, width: self.c_w, height: self.textview!.c_h + self.image!.c_h + self.collection!.c_h)
        //老师解答View
        self.jiexi.frame = CGRect(x: 15, y: self.questionView.c_maxY(), width: 40, height: 30)
        self.defen.frame = CGRect.init(x: self.jiexi.c_maxX(), y: self.jiexi.c_y, width: SCREEN_WIDTH, height: 30)

        let Height = self.jiexiView.sizeThatFits(CGSize(width: self.c_w, height: 200)).height
        self.jiexiView.frame = CGRect.init(x: 15, y: self.defen.c_maxY(), width: self.c_w - 30, height: Height)
        
        self.tijiao.frame = CGRect.init(x: 20, y: self.jiexiView.c_maxY(), width: self.c_w - 40, height: 35)
        
        
    }
    
    
    func setData(model:Model_DanxuanJiLu)  {
        self.model = model

        self.textview?.text = model.Stem.urlDecoded() + "(" + model.Score.string() + "分)"

        
        self.image?.c_setImage(url: model.StemImg)
        
        //通过富文本来设置行间距
        let paraph = NSMutableParagraphStyle()
        //将行间距设置为28
        paraph.lineSpacing = 5
        self.jiexiView.attributedText = NSAttributedString(string: "解析:" + "\n\n" + model.Analysis.urlDecoded(), attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12),NSAttributedStringKey.paragraphStyle: paraph])
        self.collection?.setDataSource(images: model.ContentAddress.StringToArray())
        self.defen.text = (self.model?.myQuestionBody?.Score ?? 0).string()

        upDataFrame()
    }
}

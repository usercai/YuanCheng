//
//  TiankongView.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/5.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import RxSwift
class JL_TiankongView: UIView {
    
    var textview : UITextView? = nil
    var image : UIImageView? = nil
    var jiexiView:UITextView = UITextView()
    var jiexiButton:UIButton = UIButton()
    let dis = DisposeBag()
    var collection : CShowCollectionView? = nil
    var showjiexi = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView()  {
        
        self.textview = UITextView(frame: .init(x: 0, y: 0, width: SCREEN_WIDTH, height: 100))
        self.textview?.isEditable = false
        self.textview?.backgroundColor = UIColor(hex: "#e5f2ff")
        self.textview?.textColor = TextColor
        self.addSubview(self.textview!)
        
        self.image = UIImageView(frame: CGRect.init(x: 20, y: self.textview!.c_maxY(), width: 70, height: 70))
        self.image?.clipsToBounds = true
        self.image?.contentMode = .scaleAspectFill
        self.addSubview(self.image!)
        self.image?.isUserInteractionEnabled = true
//        self.image?.setLayerForNormal(cornerRadius: 5, linecolorcolor: TINTCOLOR, linewidth: 1)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick))
        self.image?.addGestureRecognizer(tap)
        
        self.collection = CShowCollectionView(frame: CGRect.init(x: 0, y: self.image!.c_maxY(), width: self.frame.width, height: 100))
        
        self.addSubview(self.collection!)
        
        
        self.jiexiButton.frame = CGRect.init(x: 0, y: self.c_h - 60, width: self.c_w, height: 30)
        self.jiexiButton.setTitle("解析", for: .normal)
        self.jiexiButton.backgroundColor = LineColor
        self.jiexiButton.setTitleColor(TextColor, for: .normal)
        self.jiexiButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.jiexiButton.rx.tap.subscribe { (event) in
            self.showjiexi = !self.showjiexi
            self.showHidenJiexi(ShowOrHidden: self.showjiexi)
        }.disposed(by: dis)
        self.addSubview(self.jiexiButton)
        
        self.jiexiView.frame = CGRect.init(x: 0, y: self.c_h - TabStateBarHeight, width: self.c_w, height: 0)
        self.jiexiView.isEditable = false
        self.jiexiView.backgroundColor = WHITEColor
        
        self.addSubview(self.jiexiView)
        
        
    }
    

    @objc func tapClick() {
        CImageViewer.shared.showViewer(images: [self.image!])
    }
    func showHidenJiexi(ShowOrHidden:Bool){

        switch ShowOrHidden {
        case true:
            self.jiexiButton.backgroundColor = TINTCOLOR
            self.jiexiButton.setTitleColor(WHITEColor, for: .normal)
            UIView.animate(withDuration: 0.5, animations: {
                self.jiexiView.frame = CGRect.init(x: 0, y: self.c_h - 270, width: self.c_w, height: 270)
                self.jiexiButton.frame = CGRect.init(x: 0, y: self.c_h - 300, width: self.c_w, height: 30)
            })
        default:
            self.jiexiButton.backgroundColor = LineColor
            self.jiexiButton.setTitleColor(TextColor, for: .normal)
            UIView.animate(withDuration: 0.5, animations: {
                self.jiexiView.frame = CGRect.init(x: 0, y: self.c_h, width: self.c_w, height: 0)
                self.jiexiButton.frame = CGRect.init(x: 0, y: self.c_h - 60, width: self.c_w, height: 30)
            })
        }
    }
    
    
    
    func setData(model:Model_DanxuanJiLu)  {
        
        self.textview?.text = model.Stem.urlDecoded() + "(" + model.Score.string() + "分)"
        if model.StemImg == "" {
            self.image?.c_setHeight(height: 0)
        }else{
            self.image?.c_setHeight(height: 70)
        }
        
        self.image?.c_setImage(url: model.StemImg)
        
        //通过富文本来设置行间距
        let paraph = NSMutableParagraphStyle()
        //将行间距设置为28
        paraph.lineSpacing = 5
        self.jiexiView.attributedText = NSAttributedString(string: "解析:" + "\n\n" + model.Analysis.urlDecoded(), attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12),NSAttributedStringKey.paragraphStyle: paraph])
        self.collection?.setDataSource(images: model.ContentAddress.StringToArray())
    }
}

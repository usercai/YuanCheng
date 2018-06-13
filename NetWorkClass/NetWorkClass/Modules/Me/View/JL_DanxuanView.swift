//
//  DanxuanView.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/28.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import RxSwift
import ImageViewer



class JL_DanxuanView: UIView {

    @IBOutlet weak var tableview_h: NSLayoutConstraint!
    @IBOutlet weak var jiexibutton: UIButton!
    @IBOutlet weak var imageheight: NSLayoutConstraint!
    
    @IBOutlet weak var jiexieViewHeight: NSLayoutConstraint!
    @IBOutlet weak var jiexitextview: UITextView!
    @IBOutlet weak var jiexiView: UIView!
    @IBOutlet weak var SubjectInfo: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var image: UIImageView!
    let dis = DisposeBag()
    
    var selectArr = NSMutableArray()
    
    fileprivate var type:TextType = .Danxuan
    var model : Model_DanxuanJiLu?
    
    /// 是否显示解析
    var showJiexi = Variable<Bool>(false)

    /// 放大图片
    var showImage:[DataItem] = []
    
    var paraph:[NSAttributedStringKey:Any] = [:]
    
    /// 正确答案
    var rightOption:[Int] = []
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.tableView.register(UINib.init(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: "OptionTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.isScrollEnabled = false
        self.tableView.separatorStyle = .none
        self.jiexitextview.isEditable = false
        self.jiexiView.isHidden = true
        self.jiexitextview.font = UIFont.systemFont(ofSize: 12)
        self.jiexitextview.textColor = TextColor
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick))
        self.image.isUserInteractionEnabled = true
        self.image.addGestureRecognizer(tap)

        
        //通过富文本来设置行间距
        let paraph = NSMutableParagraphStyle()
        //将行间距设置为28
        paraph.lineSpacing = 5
        //样式属性集合
        self.paraph = [NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue):UIFont.systemFont(ofSize: 12),
                       NSAttributedStringKey(rawValue: NSAttributedStringKey.paragraphStyle.rawValue): paraph]

        
        self.showJiexi.asObservable().subscribe(onNext: { (isshow) in
            if self.model != nil{
                if isshow == true{

                    UIView.animate(withDuration: 0.5, animations: {
//                        self.jiexiView.frame = CGRect.init(x: 0, y: self.c_h - 300, width: self.c_w, height: 300)
                        self.jiexieViewHeight.constant = 300

                    })
                    self.jiexibutton.backgroundColor=TINTCOLOR
                    self.jiexibutton.setTitleColor(WHITEColor, for: .normal)

                }else{
                    
                    UIView.animate(withDuration: 0.5, animations: {
//                        self.jiexiView.frame = CGRect.init(x: 0, y: self.c_h - 30, width: self.c_w, height: 30)
                        self.jiexieViewHeight.constant = 30

                    })
                    self.jiexibutton.backgroundColor = LineColor
                    self.jiexibutton.setTitleColor(TextColor, for: .normal)

                }
            }

        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: dis)
    }
    @objc func tapClick(){
        
        self.showImage = AppTool.setImageForDataItem(images: [self.image])

        let viewcontroller = GalleryViewController.init(startIndex: 0, itemsDataSource: self, itemsDelegate: nil, displacedViewsDataSource: nil, configuration: AppTool.galleryConfiguration())
        
        AppTool.currentViewController()?.presentImageGallery(viewcontroller)
    }
    
    @IBAction func JieXiClick(_ sender: UIButton) {
        
        if self.model != nil {
            self.showJiexi.value = !self.showJiexi.value
        }
    }
    

    
    func getData(model:Model_DanxuanJiLu) {
        
        self.selectArr.removeAllObjects()
        self.model = model
        self.type = self.model!.FixedType.typeforTextType()
        self.rightOption.removeAll()

//        self.title.text = model.TypeName
        self.SubjectInfo.text = model.Stem.urlDecoded() + "(" + model.Score.string() + "分)"
        self.image.c_setImage(url: model.StemImg)
        self.jiexiView.isHidden = false
        
        if model.StemImg != "" {
            self.imageheight.constant = 70
        }
        
        
        for (index,value) in self.model!.QuestionBody.enumerated() {
            if value.IsRight == 1{
                self.rightOption.append(index)
            }
        }
        
        self.jiexitextview.attributedText = NSAttributedString(string: "正确答案:" + self.rightOption.ABCD() + "\n\n" + self.model!.Analysis.urlDecoded(), attributes: self.paraph)
        
        //显示自己的选择
        self.selectArr.addObjects(from: model.QuestionBodyID.stringForIntArray())

        var h:CGFloat = 0
        for model in self.model!.QuestionBody {
            let value = model.OptionValue
            h = h + (value.autoLabelHeight(with: SCREEN_WIDTH - 80, font: 14) + 25)
            
        }
        
        self.tableview_h.constant = h + 50

        self.tableView.reloadData()

    }
    
    
    

}

extension JL_DanxuanView:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionTableViewCell", for: indexPath) as! OptionTableViewCell
        let model = self.model?.QuestionBody[indexPath.row]
        if model != nil {
            
            cell.cellforModel(model: model!)
            cell.xuanxiang.setTitle(indexPath.row.ABCD(), for: .normal)

            if self.selectArr.contains(model?.QuestionBodyID ?? 0){
                if self.rightOption.contains(indexPath.row){
                    cell.rightCell()
                }else{
                    cell.errorCell()
                }
            }else{
                cell.normalCell()
            }
            
            
        }

        
        cell.selectionStyle = .none

        
        //判断是否是正确答案
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = self.model?.QuestionBody[indexPath.row]
        let value = model?.OptionValue ?? ""
        return value.autoLabelHeight(with: SCREEN_WIDTH - 80, font: 14) + 20
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.QuestionBody.count ?? 0
    }
    
}

extension JL_DanxuanView:GalleryItemsDataSource{
    func itemCount() -> Int {
        return self.showImage.count
    }
    
    func provideGalleryItem(_ index: Int) -> GalleryItem {
        
        let item = self.showImage[index].galleryItem
        return item
        
    }
}

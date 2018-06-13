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



class LX_DanxuanView: UIView {

    @IBOutlet weak var jiexibutton: UIButton!
    @IBOutlet weak var imageheight: NSLayoutConstraint!
    
    @IBOutlet weak var tablebuttom_h: NSLayoutConstraint!
    @IBOutlet weak var jiexieViewHeight: NSLayoutConstraint!
    @IBOutlet weak var jiexitextview: UITextView!
    @IBOutlet weak var jiexiView: UIView!
    @IBOutlet weak var SubjectInfo: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var image: UIImageView!
    let dis = DisposeBag()
    
    var selectArr = NSMutableArray()
    
    fileprivate var type:TextType = .Danxuan
    var model : Model_Danxuan?
    
    @IBOutlet weak var tableView_H: NSLayoutConstraint!
    /// 是否显示解析
    var showJiexi = Variable<Bool>(false)
    /// 是否正确
    var Right = Variable<Bool>(false)
    var MySelect = Variable<[Int]>([])
    /// 放大图片
    var showImage:[DataItem] = []
    
    var paraph:[NSAttributedStringKey:Any] = [:]
    
    
    
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
                        
//                        self.jiexiView.frame = CGRect.init(x: 0, y:  100, width: self.c_w, height: 30)
//                        self.tablebuttom_h.constant = 200
                        self.jiexieViewHeight.constant = 200

                    })
                    self.jiexibutton.backgroundColor=TINTCOLOR
                    self.jiexibutton.setTitleColor(WHITEColor, for: .normal)

                }else{
                    
                    UIView.animate(withDuration: 0.5, animations: {
//                        self.jiexiView.frame = CGRect.init(x: 0, y: self.c_h - 30, width: self.c_w, height: 30)
//                        self.tablebuttom_h.constant = 30

                        self.jiexieViewHeight.constant = 30

                    })
                    self.jiexibutton.backgroundColor = LineColor
                    self.jiexibutton.setTitleColor(TextColor, for: .normal)

                }
            }

        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: dis)
    }
    @objc func tapClick(){
        
        let viewcontroller = GalleryViewController.init(startIndex: 0, itemsDataSource: self, itemsDelegate: nil, displacedViewsDataSource: nil, configuration: AppTool.galleryConfiguration())
        
        AppTool.currentViewController()?.presentImageGallery(viewcontroller)
    }
    
    @IBAction func JieXiClick(_ sender: UIButton) {
        
        if self.model != nil {
            self.showJiexi.value = !self.showJiexi.value
        }
    }
    

    
    func getData(model:Model_Danxuan,SelectIndex:[Int]) {
        
        self.selectArr.removeAllObjects()
        self.model = model
        self.type = self.model!.FixedType.typeforTextType()


//        self.title.text = model.TypeName
        self.SubjectInfo.text = model.Stem.removingPercentEncoding
        self.image.c_setImage(url: model.StemImg)
        self.tableView.reloadData()
        self.jiexiView.isHidden = false
        if model.StemImg != "" {
            self.imageheight.constant = 70
        }
        
        var rightNum = 0
        for (index,value) in self.model!.QuestionBody.enumerated() {
            if value.IsRight == 1{
                rightNum = index
            }
        }
        
        self.jiexitextview.attributedText = NSAttributedString(string: "正确答案:" + rightNum.ABCD() + "\n\n" + self.model!.Analysis.urlDecoded(), attributes: self.paraph)
        
        //显示上一次选择的
        self.selectArr.addObjects(from: SelectIndex)
        self.tableView.reloadData()
        
        self.showImage = AppTool.setImageForDataItem(images: [self.image])
        
        
        ///控制ScrollView的大小,调整位置
        var h:CGFloat = 0
        for model in self.model!.QuestionBody {
            let value = model.OptionValue
            h = h + (value.autoLabelHeight(with: SCREEN_WIDTH - 80, font: 14) + 20)
            
        }
        
        self.tableView_H.constant = h + 50

    }
    
    
    

}

extension LX_DanxuanView:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionTableViewCell", for: indexPath) as! OptionTableViewCell
        let model = self.model?.QuestionBody[indexPath.row]
        if model != nil {
            cell.cellforModel(model: model!)
        }
        cell.xuanxiang.setTitle(indexPath.row.ABCD(), for: .normal)
        if self.selectArr.contains(indexPath.row){

            cell.selectCell()
        }else{
            cell.normalCell()
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.showJiexi.value == true {
            return
        }
        let model = self.model?.QuestionBody[indexPath.row]

        switch self.type {
        case .Danxuan,.Panduan:
            self.selectArr.removeAllObjects()
            self.selectArr.add(indexPath.row)

        case .Duoxuan:
            if self.selectArr.contains(indexPath.row){
                self.selectArr.remove(indexPath.row)
            }else{
                self.selectArr.add(indexPath.row)
            }

        default:
            break
            
        }
        
        self.tableView.reloadData()
        
        
        self.MySelect.value = self.selectArr as! [Int]

        //判断单选是否正确
        if model?.IsRight == 1 && (self.type == .Danxuan || self.type == .Panduan){
            self.Right.value = true
        }else{
            self.showJiexi.value = true
        }
        
    }
    
    
    
}

extension LX_DanxuanView:GalleryItemsDataSource{
    func itemCount() -> Int {
        return self.showImage.count
    }
    
    func provideGalleryItem(_ index: Int) -> GalleryItem {
        
        let item = self.showImage[index].galleryItem
        return item
        
    }
    
    
    
}

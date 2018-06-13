//
//  MeViewModel.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/21.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift

class MeViewModel: BaseViewModel {

    
    var dataSource = NSArray()
    var imageSource = NSArray()
    
    let topContentInset:CGFloat = 208
    let headImage = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 70, height: 70))
    let headView = UIImageView(image: AppTool.getImageWithColor(color: RGB(R: 33, G: 94, B: 161)))
    let name = UILabel()
    let age = UILabel()
    let userinfo = UILabel()
    let setting = UIButton()
    
    
    
    override func registerCell(tableView:UITableView){
        
        tableView.register(UINib.init(nibName: "MeTableViewCell", bundle: nil), forCellReuseIdentifier: "MeTableViewCell")

        self.headView.frame = CGRect(x: 0, y: -topContentInset, width: SCREEN_WIDTH, height: topContentInset)
        self.headView.contentMode = .scaleAspectFill
        self.headView.clipsToBounds = true
        self.headView.isUserInteractionEnabled = true
        
        
        tableView.contentInset = UIEdgeInsetsMake(topContentInset, 0, 0, 0)
        tableView.addSubview(self.headView)
        
        initView()

    }
    
    override init() {
        
        super.init()
        
        self.dataSource = ["习题记录","提问记录","作业记录"]
        self.imageSource = [#imageLiteral(resourceName: "me_xitijilu1"),#imageLiteral(resourceName: "me_tiwen"),#imageLiteral(resourceName: "me_zuoye1")]
        
        
    }
    
    func initView() {
        
        //头像
        self.headImage.layer.cornerRadius = self.headImage.c_w/2
        self.headImage.clipsToBounds = true
        self.headImage.image = #imageLiteral(resourceName: "userLogo")
        self.headImage.center = self.headView.c_Selfcenter

        if KUserInfo.UserRole == .Student {
            KUserInfo.userpic.asObservable().subscribe(onNext: { (pic) in
                self.headImage.c_setImage(url: pic)
                
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        }

        self.headView.addSubview(self.headImage)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
        self.headImage.isUserInteractionEnabled = true
        self.headImage.addGestureRecognizer(tap)
        //名字
        self.name.textColor = UIColor.white
        self.name.frame = CGRect.init(x: 0, y: self.headImage.c_y + 70+10, width: SCREEN_WIDTH, height: 20)
        self.name.font = CFont_16
        self.name.textAlignment = .center
        self.name.text = KUserInfo.UserRole == .Student ? KUserInfo.user.StuName : ""
        self.headView.addSubview(self.name)
        //年龄
        self.age.frame = CGRect.init(x: 0, y: self.name.c_maxY()+6, width: SCREEN_WIDTH, height: 16)
        self.age.font = CFont_12
        self.age.textColor = WHITEColor
        self.age.textAlignment = .center
        self.age.text = KUserInfo.user.GradeName == "" ? "暂无" : KUserInfo.user.GradeName
        self.headView.addSubview(self.age)
        //详情
        self.userinfo.frame = CGRect.init(x: 0, y: self.age.c_maxY()+8, width: SCREEN_WIDTH, height: 16)
        self.userinfo.textColor = WHITEColor.alpha(0.6)
        self.userinfo.textAlignment = .center
        self.userinfo.text =  KUserInfo.user.ClassesName == "" ? "什么都没有留下" : KUserInfo.user.ClassesName
        self.userinfo.font = CFont_12
        self.headView.addSubview(self.userinfo)
        //设置
        self.setting.frame = CGRect.init(x: SCREEN_WIDTH - 51 , y: StateBarHeight + 30, width: 22, height: 22)
        self.setting.setBackgroundImage(#imageLiteral(resourceName: "me_setting"), for: .normal)
        self.setting.rx.tap.asObservable().subscribe { (event) in
            let vc = Me_SettingViewController()
            AppTool.currentViewController()?.navigationController?.pushViewController(vc, animated: true)
            
        }.disposed(by: disposeBag)
        self.headView.addSubview(self.setting)
    }
    
    
    @objc func tapClick() {
        CImageViewer.shared.showViewer(images: [self.headImage])
    }
}



extension MeViewModel:UITableViewDelegate,UITableViewDataSource{
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeTableViewCell", for: indexPath) as! MeTableViewCell
        cell.headimage?.image = self.imageSource[indexPath.row] as? UIImage
        cell.title?.text = self.dataSource[indexPath.row] as? String
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        

        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offY = scrollView.contentOffset.y
        // 根据偏移量改变alpha的值
        //        customNavc?.alpha = (offY + 64) / (topImageHeight - 64) + 1
        // 设置图片的高度 和 Y 值
        if offY < -topContentInset {
            headView.frame.origin.y = offY
            headView.frame.size.height = -offY
        }
        
    }
    

}

//
//  Me_SettingViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/12.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import ImagePicker
import PushKit
class Me_SettingViewController: BaseTableViewController {

    let viewmodel = UpLoadViewModel()
    let button = UIButton(frame: CGRect.init(x: 20, y: 300, width: SCREEN_WIDTH - 40, height: 40))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
        // Do any additional setup after loading the view.
    }

    override func initView() {
        
        button.backgroundColor = TINTCOLOR
        button.setTitle("退出", for: .normal)
        button.titleLabel?.font = CFont_14
        button.setLayer(cornerRadius: 5, linecolorcolor: TINTCOLOR, linewidth: 0, ReacCorner: .all)
        //退出登录
        button.addTarget(self, action: #selector(logout), for: .touchUpInside)

        
        self.tableView.addSubview(button)
    }
    
    @objc func logout() {
        DispatchQueue.main.async {
            
            let vc = BaseNaviViewController(rootViewController: LoginViewController())
            KWindow?.rootViewController = vc
        }
        JPUSHService.deleteAlias({ (code, str, issu) in
            KUserInfo.Key = ""
        }, seq: 1)
    }
    override func RegisterCell() {
        self.tableView.register(UINib.init(nibName: "Me_SettingTableViewCell", bundle: nil), forCellReuseIdentifier: "Me_SettingTableViewCell")
        self.tableView.register(UINib.init(nibName: "Me_SettingTestTableViewCell", bundle: nil), forCellReuseIdentifier: "Me_SettingTestTableViewCell")
    }
    override func initData() {
        self.dataSource = [""]
    }
    
    func uploadImage(image:UIImage) {
        
        let out = self.viewmodel.upLoad(fileArr: [image.base64().utf8encodedString()], name: "jpg", fileAddress: .HomeworkImg)
        out.models.asDriver().drive(onNext: { (models) in
            if models.count == 1{
                KUserInfo.user.Picture = models.first!.path
                KUserInfo.userpic.value = KUserInfo.user.Picture
                self.tableView.reloadData()
                self.updatestupicture(pic: KUserInfo.user.Picture)
            }
        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)
        
    }
    func updatestupicture(pic:String) {
        MeTool.rx.request(MeApi.UpdateStuPicture(pic)).asObservable().subscribe(onNext: { (res) in
            res.C_mapjson(success: { (dic) in
                CProgressHUD.showText(text: "上传成功")

            }, falue: { (code, msg) in
                CProgressHUD.showText(text: "上传失败")

            })
        }, onError: { (error) in
            CProgressHUD.showText(text: "上传失败")

        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)
    }
}


extension Me_SettingViewController{
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Me_SettingTableViewCell", for: indexPath) as! Me_SettingTableViewCell
            cell.titletext?.text = "点击修改头像"
            cell.userimage.c_setImage(url: KUserInfo.user.Picture, placeholderImage: #imageLiteral(resourceName: "userLogo"))
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "Me_SettingTestTableViewCell", for: indexPath) as! Me_SettingTestTableViewCell
        switch indexPath.row {
        case 1:
            cell.titletext?.text = "清理缓存"
            cell.infotext?.text = CCacheTool.fileSizeOfCache().string() + "M"
        default:
            cell.titletext?.text = "当前版本"
            cell.infotext?.text = AppVersion
        }
        
        
        return cell

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 60
        }
        return 45
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.row == 0 {
            if KUserInfo.UserRole == .Student{
                let image = CImagePicker.init(maxSelectNum: 1)
                image.imagepicker?.delegate = self
                self.present(image.imagepicker!, animated: true, completion: nil)
            }else{
                CProgressHUD.showText(text: "教师暂时无法修改头像")
            }

        }else if indexPath.row == 1{
            
            DispatchQueue.main.async {
                AppTool.showAlert(title: "是否清除缓存", QAction: {
                    CProgressHUD.showLoading()
                    let issuccess = CCacheTool.clearCache()
                    if issuccess == false{
                        CProgressHUD.showText(text: "清除失败")
                    }else{
                        CProgressHUD.showText(text: "清除成功")
                        self.tableView.reloadData()
                    }
                })
            }
        }else{
            
        }
    }
}


extension Me_SettingViewController:ImagePickerDelegate{
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
        
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
        imagePicker.dismiss(animated: true, completion: nil)
        if images.count == 1 {
            self.uploadImage(image: images.first!)

        }
    }
}


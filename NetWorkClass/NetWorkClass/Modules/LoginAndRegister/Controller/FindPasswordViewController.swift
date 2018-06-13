//
//  FindPasswordViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/19.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import TextFieldEffects
import RxSwift

class FindPasswordViewController: UIViewController {

    @IBOutlet weak var scrollContentviewheight: NSLayoutConstraint!
    @IBOutlet weak var finish: UIButton!
    @IBOutlet weak var password2: KaedeTextField!
    @IBOutlet weak var password: KaedeTextField!
    @IBOutlet weak var VerificationCode: KaedeTextField!
    @IBOutlet weak var phonenum: KaedeTextField!
    @IBOutlet weak var VerificationBtn: JKCountDownButton!
    
    
    let dis = DisposeBag()
    
    let viewmodel = FindPasswordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        // Do any additional setup after loading the view.
    }
    func initView() {
        self.VerificationBtn.setLayerForNormal(cornerRadius: 4)
        self.finish.setLayerForNormal(cornerRadius: 5)
        self.scrollContentviewheight.constant = SCREEN_HEIGHT + 1
        self.title = "手机找回密码"
        self.setNaviForClear()
    }
    

}


// MARK: - 点击方法
extension FindPasswordViewController{
    
    @IBAction func finish(_ sender: UIButton) {
        
        if AppTool.CisEmpty(str: self.phonenum.text){
            CProgressHUD.showText(text: "手机号不能为空")
            return
        }
        if AppTool.CisEmpty(str: self.VerificationCode.text) {
            CProgressHUD.showText(text: "验证码不能为空")
            return
        }
        if AppTool.CisEmpty(str: self.password.text) {
            CProgressHUD.showText(text: "密码不能为空")
            return
        }
        if self.password.text != self.password2.text {
            CProgressHUD.showText(text: "密码需要保持一致")
            return
        }
        
        let output = self.viewmodel.getDataList(password: self.password.text!, VerificationPhone: self.phonenum.text!, verificationCode: self.VerificationCode.text!)
        output.models.asDriver().drive(onNext: { (models) in

            if models == true{
                self.navigationController?.popViewController(animated: true)
            }
        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)

        output.requestCommond.onNext(true)


    }

    @IBAction func verfication(_ sender: JKCountDownButton) {
        if self.phonenum.text == "" {
            CProgressHUD.showText(text: "请输入正确的手机号")
            return
        }
        sender.startCountDown(withSecond: 30)
        sender.countDownChanging { (btn, second) -> String? in
            btn?.isEnabled = false
            return "\(second)"
        }
        sender.countDownFinished { (btn, second) -> String? in
            btn?.isEnabled = true
            return "验证码"
        }
        self.viewmodel.getDataList(phone: self.phonenum.text!, contrycode: "86")
    }
}

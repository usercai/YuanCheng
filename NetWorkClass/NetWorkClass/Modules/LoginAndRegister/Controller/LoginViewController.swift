//
//  LoginViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/17.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import TextFieldEffects
import RxSwift
import ObjectMapper

class LoginViewController: UIViewController {

    let dis = DisposeBag()

    @IBOutlet weak var ContentView_H: NSLayoutConstraint!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var roleButton: UIButton!
    @IBOutlet weak var passwordview: UIView!
    @IBOutlet weak var accoutview: UIView!
    @IBOutlet weak var passwordtextfield: UITextField!
    @IBOutlet weak var accouttextfield: UITextField!
    var loginManager = LoginManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let useraccount = KeyChainTool.getUserAccount()
        
        if AppTool.CisEmpty(str: useraccount) {
            self.present(SelectRoleViewController(), animated: true, completion: nil)
        }
        self.ContentView_H.constant = SCREEN_HEIGHT
//        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        initView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    

    @IBAction func backClick(_ sender: UIButton) {
        self.present(SelectRoleViewController(), animated: true, completion: nil)
    }
    
}

extension LoginViewController{

    
    /// 处理试图
    func initView() {

        
        self.navigationController?.navigationBar.isHidden = true
        switch KUserInfo.UserRole {
        case .Teacher:
            roleButton.setBackgroundImage( #imageLiteral(resourceName: "login_teacherDeep"), for: .normal)
        default:
            roleButton.setBackgroundImage(#imageLiteral(resourceName: "login_studentDeep"), for: .normal)
        }
        
        self.login.setLayer(cornerRadius: 3, linecolorcolor: TINTCOLOR, linewidth: 1, ReacCorner: .all)
        self.accoutview.setLayerForNormal(cornerRadius: 3, linecolorcolor: TINTCOLOR, linewidth: 1)
        self.passwordview.setLayerForNormal(cornerRadius: 3, linecolorcolor: TINTCOLOR, linewidth: 1)
        

        self.accouttextfield.text = KeyChainTool.getUserAccount()
        self.passwordtextfield.text = KeyChainTool.getPassWord()
        
        self.passwordtextfield.isSecureTextEntry = true
    }
}

// MARK: - Action
extension LoginViewController{
    
    /// 选择角色
    ///
    /// - Parameter sender:
    @IBAction func selectrole(_ sender: UIButton) {
        
        let vc = SelectRoleViewController()

        self.present(vc, animated: true, completion: nil)
    }
    
    /// 登录
    ///
    /// - Parameter sender:
    @IBAction func login(_ sender: UIButton) {
        

        self.loginManager.Login(username: self.accouttextfield.text!, password: self.passwordtextfield.text!, type: KUserInfo.UserRole)
        self.loginManager.LoginResults.asObservable().skipWhile { $0 == true }.subscribe(onNext: { (issucess) in
            
            if issucess == true{
                if KUserInfo.UserRole == .Teacher{
                    KWindow?.rootViewController = TeacherTabbarViewController()
                }else{
                    KWindow?.rootViewController = BaseTabbarController()
                    
                }
            }

        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: dis)

        
    }
    
    
    /// 忘记密码
    ///
    /// - Parameter sender:
    @IBAction func forgetpassword(_ sender: UIButton) {

        let vc = FindPasswordViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
//        let vc = htmlViewController()
//        self.present(vc, animated: true, completion: nil)
    }
}

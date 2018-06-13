//
//  StartViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/13.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class StartViewController: BaseViewController {

    @IBOutlet weak var startimage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func initView() {
        
        self.startimage.image = AppTool.getLauchImage()
//        AppTool.getLauchImage()
        
        
        let useraccount = KeyChainTool.getUserAccount()
        let password = KeyChainTool.getPassWord()
        let role = KeyChainTool.getRole()

        if AppTool.CisEmpty(str: useraccount) || AppTool.CisEmpty(str: password){
            
            let vc = BaseNaviViewController(rootViewController: LoginViewController())
            KWindow?.rootViewController = vc
        }else{
            
            let login = LoginManager()
            login.Login(username: useraccount, password: password, type: role)
            login.LoginResults.asObservable().skip(1).subscribe(onNext: { (issucess) in
                if issucess == true{
                    if KUserInfo.UserRole == .Student{
                        KWindow?.rootViewController = BaseTabbarController()
                    }else{
                        KWindow?.rootViewController = TeacherTabbarViewController()
                    }
                }else{
                    let vc = BaseNaviViewController(rootViewController: LoginViewController())
                    KWindow?.rootViewController = vc
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: dis)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

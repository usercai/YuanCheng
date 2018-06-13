//
//  Home_NewsHtmlViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/27.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class Home_NewsHtmlViewController: BaseViewController {

    private var url = ""
    lazy var webView: UIWebView = {
        let webView = UIWebView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - TabStateBarHeight))
        webView.isMultipleTouchEnabled = true
        webView.scalesPageToFit = true
        webView.delegate = self
        webView.scrollView.delegate = self
        webView.backgroundColor = UIColor.white
        
        return webView
    }()
    private var noticeId = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "详情"
        // Do any additional setup after loading the view.
        
    }
    convenience init(noticeId:Int) {
        self.init()
        self.noticeId = noticeId
    }
    
    override func initData() {
        homePageTool.rx.request(HomePageApi.QueryNoticeUrl()).asObservable().subscribe(onNext: { (res) in
            res.C_mapjson(success: { (dic) in
                if dic.keys.contains("url"){
                    self.url = dic["url"] as! String
                    self.initWeb()
                }
            }, falue: { (code, msg) in
                
            })
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: dis)
        
    }
    override func initView() {
        self.webView.delegate = self
        self.view.addSubview(self.webView)
    }
    func initWeb() {
        let url = self.url + "?noticeid=" + self.noticeId.string()
        self.webView.loadRequest(URLRequest.init(url: url.url()))
    }


}

extension Home_NewsHtmlViewController:UIWebViewDelegate,UIScrollViewDelegate{
    func webViewDidStartLoad(_ webView: UIWebView) {
        CProgressHUD.showLoading()
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        CProgressHUD.hiddenLoading()
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if velocity.y < 0.0 {
            
            //下滑
            navigationController?.setNavigationBarHidden(false, animated: true)
            
        } else {
            
            //上滑
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
}

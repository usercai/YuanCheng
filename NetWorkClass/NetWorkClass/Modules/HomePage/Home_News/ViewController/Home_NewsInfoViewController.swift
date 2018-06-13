//
//  Home_NewsInfoViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/9.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import WebKit

class Home_NewsInfoViewController: BaseViewController {

    let viewmodel = Home_NoticeInfoViewModel()
    @IBOutlet weak var scrollcontentView_H: NSLayoutConstraint!

    @IBOutlet weak var NewsTime: UILabel!
    @IBOutlet weak var Newstitle: UILabel!
    var noticeId = 0
    var model:Model_HomeView?
    private var webView:WKWebView? = nil
    
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
        let output = self.viewmodel.getDataList(noticeId: self.noticeId)
        output.models.asDriver().drive(onNext: { (models) in

            self.model = models.first
            if self.model != nil{
                self.setView()
            }
        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)
        
        output.requestCommond.onNext(true)

    }
    
    func setView() {
        self.NewsTime?.text = (self.model?.Author ?? "") + " | " + (self.model?.CreateDateTime.timeString() ?? "")

        self.Newstitle?.text = self.model?.Title
        let config = WKWebViewConfiguration.init()
        config.preferences.minimumFontSize = 10

        self.webView = WKWebView(frame: CGRect(x: 15, y: 10 + 70, width: SCREEN_WIDTH - 30, height: SCREEN_HEIGHT - 80 - NaviBarHeight), configuration: config)
        self.webView?.loadHTMLString(self.model?.Contents.urlDecoded() ?? "", baseURL: nil)
        self.webView?.navigationDelegate = self
        self.webView?.scrollView.showsVerticalScrollIndicator = false
        self.webView?.scrollView.showsHorizontalScrollIndicator = false

        self.view.addSubview(self.webView!)
    }
    
    override func initView() {
        
        self.scrollcontentView_H.constant = SCREEN_HEIGHT - NaviBarHeight - StateBarHeight
    }
}

extension Home_NewsInfoViewController:WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '270%'", completionHandler: nil)
        //修改字体大小 300%

        webView.evaluateJavaScript("document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#333333'", completionHandler: nil)
        
        //修改字体颜色  #9098b8

    }
}



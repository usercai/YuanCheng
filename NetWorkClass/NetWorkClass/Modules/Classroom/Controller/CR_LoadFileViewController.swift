//
//  CR_LoadFileViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/11.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import PathKit
import WebKit
class CR_LoadFileViewController: BaseViewController {

    @IBOutlet weak var fileprogress: UILabel!
    @IBOutlet weak var fileimage: UIImageView!
    @IBOutlet weak var filename: UILabel!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBOutlet weak var scrollcontentView: UIView!
    
    
    var fileSize = ""
    var isNoDownload = false
    
    
    var wkweb : UIWebView?
    
    
    fileprivate var fileContent = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.deleteBtn.rx.tap.asObservable().subscribe { (event) in
            ClassRoomTool.cancelCompletion({ (result) in
                
            }, target: ClassRoomApi.QueryFileByPath(self.fileContent))
        }.disposed(by: dis)
        
        // Do any additional setup after loading the view.
    }
    convenience init(fileContent:String) {
        self.init()
        
        self.fileContent = fileContent

    }
    override func viewDidAppear(_ animated: Bool) {
        
        if isNoDownload == true && self.fileSize == "0.00MB" {
            
            DispatchQueue.global().async {
                
                do {
                    let data:NSData = try NSData.init(contentsOf: URL.init(string: BaseURL + self.fileContent)!)
                    print(CGFloat(data.length) / 1000.0)
                    self.fileSize = String.init(format: "%.2fMB", CGFloat(data.length) / 1000.0 / 1000.0)
                    
                } catch {
                    
                    self.fileSize = "0.00MB"
                    print("错误")
                }
                DispatchQueue.main.async {
                    
                    self.continueBtn.setTitle("下载(\(self.fileSize))", for: .normal)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func initView() {
        let config = WKWebViewConfiguration.init()
        config.preferences.minimumFontSize = 10
        self.wkweb = UIWebView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        self.wkweb?.delegate = self
        self.wkweb?.scalesPageToFit = true
        self.view.addSubview(self.wkweb!)
        self.wkweb?.isHidden = true
        
    }
    
    override func initData() {

//        let url = BaseURL + self.fileContent.cGetindexToEnd(index: 1) 
////        let tuple = DownloadTool.isDownloadAlearly(downloadUrl: url)
//
//        if tuple.result == .finish {
//
//            //tuple.file
//            self.wkweb?.isHidden = false
//
////            let path = path.replacingOccurrences(of: "file://", with: "")
//
//            self.wkweb?.loadRequest(URLRequest.init(url: URL.init(fileURLWithPath: tuple.file as! String)))
//
//        } else {
//
//            //tuple.file
//            print(BaseURL + self.fileContent)
////            DownloadTool.downloadFile(downloadUrl: url).progress(successHandler: { (progress) in
////
////                print(progress)
////
////            }).downloadResult(successHandler: { (isSuccess, data, path) in
////
////            })
//        }
        
//        let path = PathManager.FilePathisNull(path: self.fileContent)
//
//        if (path != nil) {
//            self.wkweb?.isHidden = false
//
//            let path = path?.path.replacingOccurrences(of: "file://", with: "")
//
//            self.wkweb?.loadRequest(URLRequest.init(url: URL.init(fileURLWithPath: path!)))
//
//        }else{
//
//            let url = self.fileContent.cGetindexToEnd(index: 1)
//
//            ClassRoomTool.rx.requestWithProgress(ClassRoomApi.QueryFileByPath(url)).asObservable().subscribe(onNext: { (progress) in
//
//                self.fileprogress.text = "\(progress.progress)"
//                if progress.progress == 1{
//                    //保存缓存,根据键值对
//                    let saveDic = AppTool.getSaveData(downloadUrL: BaseURL + self.fileContent)
//
//                    var dic:NSMutableDictionary = NSMutableDictionary.init()
//
//                    if saveDic is NSDictionary {
//
//                        dic = NSMutableDictionary.init(dictionary: saveDic as! NSDictionary)
//                    }
//
//                    dic.setObject( self.fileContent.components(separatedBy: "/").last ?? "", forKey: BaseURL + self.fileContent as NSCopying)
//
//                    dic.write(toFile: loadDataPlist, atomically: true)
//                }
//                if progress.completed == false{
//                    //意外终止的话，把已下载的数据储存起来
//                    let saveDic = AppTool.getSaveData(downloadUrL: BaseURL + self.fileContent)
//
//                    var dic:NSMutableDictionary = NSMutableDictionary.init()
//
//                    if saveDic is NSDictionary {
//
//                        dic = NSMutableDictionary.init(dictionary: saveDic as! NSDictionary)
//                    }
//
//                    dic.setObject( progress.response?.data, forKey: BaseURL + self.fileContent as NSCopying)
//
//                    dic.write(toFile: loadDataPlist, atomically: true)
//                }
//
//            }, onError: { (error) in
//
//            }, onCompleted: {
//
//
//            }) {
//
//                }.disposed(by: dis)
//
//        }

        
        
        
    }
    
    
}

extension CR_LoadFileViewController:WKNavigationDelegate,UIWebViewDelegate{
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
        print("文件损坏,重新加载")
        print(error)

    }
    
}

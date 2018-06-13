//
//  FindFileViewController.swift
//  CVolleyballAssociation
//
//  Created by 张崇超 on 2017/11/20.
//  Copyright © 2017年 Zebra. All rights reserved.
//

import UIKit
import Alamofire

class FindFileViewController: BaseViewController {

    ///下载地址
    var downloadUrl:String = "http://bmob-cdn-14976.b0.upaiyun.com/2017/11/20/976b525440ed874c8052574504a669d6.docx"
    var fileName:String!

    ///展示区
    @IBOutlet weak var logoImgV: UIImageView!
    @IBOutlet weak var fileNameL: UILabel!
    ///下载区
    @IBOutlet weak var downloadView: UIView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var downloadL: UILabel!
    ///下载按钮
    @IBOutlet weak var downloadBtn: UIButton!

    ///还剩多少没下载 MB单位
    private var noDownloadSize:String = "0.00MB"
    
    ///下载tool
    private var downloadTool:DownloadTool!
    ///下载地址
    private var downloadPath:String = ""
    ///导航栏是否隐藏
    private var isHidden:Bool = false
    ///是否已经加载过了
    fileprivate var isReloadData:Bool = false
    ///文件大小
    private var fileSize:String = "0.00MB"
    ///是否没下载过 ,默认没下载过
    private var isNoDownload:Bool = true
    private var filepic = ""
    ///文件展位图数组
    let arr:[String:String] = ["pdf":"download_pdf",
                               "docx":"download_doc",
                               "doc":"download_doc",
                               "ppt":"download_ppt",
                               "pptx":"download_ppt",
                               "xls":"download_xls",
                               "xlsx":"download_xls",
                               "mp3":"download_music"]
    
    convenience init(fileContent:String,filename:String,filePic:String) {
        self.init()
        self.downloadUrl = BaseURL + fileContent.cGetindexToEnd(index: 1)
        self.fileName = self.downloadUrl.components(separatedBy: "/").last ?? ""
        self.filepic = filePic
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.downloadView.alpha = 0.0
        view.backgroundColor = UIColor.white
        title = "下载"
        
        self.fileNameL.text = self.fileName
        
        //是否已下载
        let tuple = DownloadTool.isDownloadAlearly(downloadUrl: downloadUrl)
        if tuple.result == DownloadResult.finish {
       
            isNoDownload = false
            //下载完了
            self.downloadPath = tuple.file as! String
            self.downloadBtn.setTitle("查看", for: .normal)
       
        } else if tuple.result == DownloadResult.noFinish {
            
            isNoDownload = false
            //没下载完
            let data:NSData = tuple.file as! NSData
            
            let downloadSize:CGFloat = CGFloat(data.length) / 1000.0
            self.noDownloadSize = String.init(format: "%.2fMB", downloadSize)
            if downloadSize != 0.00 {
                
                self.downloadBtn.setTitle("继续下载(\(self.noDownloadSize))", for: .normal)
            }
        }

        let urlArr:[String] = downloadUrl.components(separatedBy: ".")
        let typeStr:String = urlArr.last!
        var imgName = arr[typeStr]
        if imgName == nil {
            
            imgName = "download_unknown"
        }
        self.logoImgV.c_setImage(url: self.filepic, placeholderImage: #imageLiteral(resourceName: "wenjian"))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isNoDownload == true && self.fileSize == "0.00MB" {
            
            DispatchQueue.global().async {
                
                do {
                    let data:NSData = try NSData.init(contentsOf: URL.init(string: self.downloadUrl)!)
                    print(CGFloat(data.length) / 1000.0)
                    self.fileSize = String.init(format: "%.2fMB", CGFloat(data.length) / 1000.0 / 1000.0)
                    
                } catch {
                    
                    self.fileSize = "0.00MB"
                    print("错误")
                }
                DispatchQueue.main.async {
                
                    self.downloadBtn.setTitle("下载(\(self.fileSize))", for: .normal)
                }
            }
        }
    }
    
    ///下载点击事件
    @IBAction func downAction(_ sender: UIButton) {
        
        if sender.titleLabel!.text!.contains("查看") {
            
            //查看
            print("查看:\(self.downloadPath)")
            
            self.title = self.fileName
            
            let urlRequest:URLRequest = URLRequest.init(url: URL.init(fileURLWithPath: self.downloadPath))
            self.showWebView.loadRequest(urlRequest)
            
            self.view.addSubview(self.showWebView)
            return
        }
        
        //开始下载
        UIView.animate(withDuration: 0.3, animations: {
            
            sender.alpha = 0.0
            self.downloadView.alpha = 1.0
            
        }) { (isOk) in
            
            self.downloadTool = DownloadTool.downloadFile(downloadUrl: self.downloadUrl).progress { (progress) in
                
                //MB单位
                let allSize:CGFloat = CGFloat(progress.totalUnitCount) / 1024.0 / 1024.0
                let downloadSize:CGFloat = CGFloat(progress.completedUnitCount) / 1024.0 / 1024.0
                
                if self.fileSize == "0.00MB" {
                    
                    self.fileSize = String.init(format: "%.2fMB", allSize)
                }
                self.downloadL.text = String.init(format: "%.2fMB", downloadSize) + "/" + self.fileSize
                
                //已下载大小
                self.noDownloadSize = String.init(format: "%.2fMB", downloadSize)
                
                //进度条更新
                self.progressView.setProgress(Float(progress.fractionCompleted), animated: true);
                print("当前进度：\(progress.fractionCompleted*100)%")
                
                }.downloadResult { (isOk, cachesData, savePath) in
                    
                    if isOk {
                        
                        self.downloadPath = savePath
                        //下载完成
                        UIView.animate(withDuration: 0.3, animations: {
                            
                            self.downloadBtn.alpha = 1.0
                            self.downloadView.alpha = 0.0
                            self.downloadBtn.setTitle("查看", for: .normal)
                        })
                        
                    } else {
                        
                        //下载失败
                        UIView.animate(withDuration: 0.3, animations: {
                            
                            self.downloadBtn.alpha = 1.0
                            self.downloadView.alpha = 0.0
                            self.downloadBtn.setTitle("下载失败,重试", for: .normal)
                        })
                    }
                }
        }
    }
    
    ///取消下载点击事件
    @IBAction func cancleAction() {
        
        if self.downloadTool == nil {
            return
        }
        DownloadTool.cancleDownload(tool: self.downloadTool).downloadResult(successHandler: { (isOk, cachesData, savePath) in
            
            print(isOk,cachesData!,savePath)
            //取消下载
            UIView.animate(withDuration: 0.3, animations: {
                
                self.downloadBtn.alpha = 1.0
                self.downloadView.alpha = 0.0
                self.downloadBtn.setTitle("继续下载(\(self.noDownloadSize))", for: .normal)
            })
        })
    }

    lazy var showWebView: UIWebView = {
        let webView = UIWebView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - TabStateBarHeight))
        webView.isMultipleTouchEnabled = true
        webView.scalesPageToFit = true
        webView.delegate = self
        webView.scrollView.delegate = self
        
        return webView
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
        if self.downloadBtn.alpha == 0.0 {
            
            //取消下载
            self.cancleAction()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension FindFileViewController:UIWebViewDelegate,UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if velocity.y < 0.0 {
            
            //下滑
            navigationController?.setNavigationBarHidden(false, animated: true)
            
        } else {
            
            //上滑
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
        print("文件损坏,重新加载")
        if isReloadData {
            
            return
        }
        
        //重新下载,文件损坏
        DownloadTool.downloadFile(downloadUrl: self.downloadUrl).downloadResult { (isOk, data, str) in
            
            DispatchQueue.main.async {
                
                self.isReloadData = true
                let urlRequest:URLRequest = URLRequest.init(url: URL.init(fileURLWithPath: str))
                self.showWebView.loadRequest(urlRequest)
            }
        }
    }
}

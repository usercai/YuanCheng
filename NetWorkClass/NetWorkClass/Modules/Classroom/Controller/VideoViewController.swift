
//
//  VideoViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/23.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import ZFPlayer
import RxSwift
import RxCocoa
import Moya
import PageMenu

class VideoViewController: BaseViewController {

    let pre = MoyaProvider<ClassRoomApi>()
    
    var pageMenu : CAPSPageMenu?
    
    let playerfatherView:UIView = {
        let view = UIView(frame: CGRect.init(x: 0, y: UIDevice.current.isX(), width: SCREEN_WIDTH, height: 200))
        
        return view
    }()
    
    private lazy var segmentedControl:UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["问答","资料"])
        segmentedControl.tintColor = TINTCOLOR
        segmentedControl.backgroundColor = WHITEColor
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.setLayerForNormal(cornerRadius: 0)
        return segmentedControl
    }()
    
    
    let playerController : ZFPlayerControlView = {
        
        let controller = ZFPlayerControlView(frame: CGRect.init(x: 0, y: UIDevice.current.isX() , width: SCREEN_WIDTH, height: 200))
        
        return controller
    }()
    
    
    let playerModel : ZFPlayerModel = {
        let playermodel = ZFPlayerModel()

        return playermodel
    }()
    
    
    let playerview : ZFPlayerView = {
        let view = ZFPlayerView()
        view.hasPreviewView = true
        return view
    }()
    
    
    var url = URL(string: "")

    var ChapterID = 0
    
    var VideoId = 0
    var SubjectId = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.playerfatherView)
        
        self.playerModel.title = ""
        self.playerModel.videoURL = url
        self.playerModel.placeholderImage = AppTool.getImageWithColor(color: UIColor.black)
        self.playerModel.fatherView = self.playerfatherView
        
        
        self.playerview.playerControlView(nil, playerModel: self.playerModel)
        self.playerview.delegate = self
        self.playerview.hasPreviewView = true

        CNetWrokReachabilityManager.share.status.asObservable().subscribe(onNext: { (type) in
            if type == .WIFI{
                
            }else if type == .wwan{
                self.playerview.pause()
                AppTool.showAlert(title: "当前网络为数据,是否继续播放", QAction: {
                    self.playerview.play()
                }, cancel: {
                    self.navigationController?.popViewController(animated: true)
                })
            }else{
                CProgressHUD.showText(text: "当前无网络")
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: dis)

    
        self.creatPlayer()

        // Do any additional setup after loading the view.
    }

    convenience init(ChapterID:Int,SubjectId:Int) {
        self.init()
        self.ChapterID = ChapterID
        self.SubjectId = SubjectId

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)

        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle  {
        
        get{
            return UIStatusBarStyle.default
        }
    }
    override var shouldAutorotate: Bool{
        return false
    }
    
    override func initView() {
        
        let vc = CR_FileViewController(id: self.ChapterID)
        let vc2 = CR_QuestionViewController.init(videoId: self.VideoId, subjectId: self.SubjectId, chapterId: self.ChapterID)
        self.segmentedControl.frame = CGRect(x: 65, y: self.playerfatherView.frame.maxY + 10, width: SCREEN_WIDTH - 130, height: 40)
        self.view.addSubview(self.segmentedControl)
        self.view.addSubview(vc2.view)
        self.view.addSubview(vc.view)
        vc.view.frame = CGRect(x: 0, y: self.segmentedControl.c_maxY() + 20, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - self.segmentedControl.c_maxY() - 20)
        vc2.view.frame = vc.view.frame
        vc.view.isHidden = true
        vc2.view.isHidden = true
        self.segmentedControl.rx.selectedSegmentIndex.asObservable().subscribe(onNext: { (index) in
            if index == 0{
                vc.view.isHidden = true
                vc2.view.isHidden = false
            }else if index == 1{

                vc.view.isHidden = false
                vc2.view.isHidden = true
            }
        }).disposed(by: dis)
    }
    
    override func initData() {
        
        self.pre.rx.request(ClassRoomApi.QueryVideo(self.ChapterID)).asObservable().mapArray(Model_Video.self).subscribe(onNext: { (models) in
            
            if models.count != 0{
                self.playerModel.videoURL = models.first?.VideoContent.UrlStr().url()
                self.playerModel.placeholderImageURLString = models.first?.Picture.UrlStr()
                self.playerview.playerControlView(nil, playerModel: self.playerModel)
                self.VideoId = models.first?.VideoID ?? 0
            }
            
        }, onError: { (error) in
            
        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)
        
    }
    
    func creatPlayer() {
        let bgView = UIView()
        bgView.frame = self.playerfatherView.bounds
        bgView.backgroundColor = UIColor.clear
        
        self.playerfatherView.addSubview(bgView)

        let centerPlayBtn = UIButton(type: UIButtonType.custom)
        
        centerPlayBtn.setImage(#imageLiteral(resourceName: "startPlay"), for: .normal)
        centerPlayBtn.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        centerPlayBtn.center = bgView.center
        
        self.playerfatherView.addSubview(centerPlayBtn)

        
        let back = UIButton(type: UIButtonType.custom)
        back.setImage( UIImage.init(named: "ZFPlayer_back"), for: UIControlState.normal)
        back.frame = CGRect(x: 20, y: 20, width: 30, height: 30)
        back.rx.controlEvent(UIControlEvents.touchUpInside).subscribe { (event) in
            self.navigationController?.popViewController(animated: true)
        }.disposed(by: dis)
        self.playerfatherView.addSubview(back)
        
        centerPlayBtn.rx.controlEvent(UIControlEvents.touchUpInside).subscribe { (event) in
            self.playerview.autoPlayTheVideo()
            centerPlayBtn.isHidden = true
            bgView.removeFromSuperview()
            back.isHidden = true
            }.disposed(by: dis)
    }

}



extension VideoViewController:ZFPlayerDelegate,ZFPlayerControlViewDelagate{
    
    func zf_playerControlViewWillShow(_ controlView: UIView!, isFullscreen fullscreen: Bool) {
        
        if fullscreen {
            
            UIView.animate(withDuration: 0.3, animations: {
                
                UIApplication.shared.isStatusBarHidden = false
            })
        }
    }
    
    func zf_playerControlViewWillHidden(_ controlView: UIView!, isFullscreen fullscreen: Bool) {
        
        if fullscreen {
            
            UIView.animate(withDuration: 0.3, animations: {
                
                UIApplication.shared.isStatusBarHidden = true
            })
        }
    }
    
    func zf_controlView(_ controlView: UIView!, fullScreenAction sender: UIButton!) {
        
        
    }
    
    func zf_controlView(_ controlView: UIView!, playAction sender: UIButton!) {
        
        if CNetWrokReachabilityManager.share.status.value == .wwan {
            self.playerview.pause()
            AppTool.showAlert(title: "当前网络为数据,是否继续播放", QAction: {
                self.playerview.play()
            }, cancel: {
                self.navigationController?.popViewController(animated: true)
            })
        }else if CNetWrokReachabilityManager.share.status.value == .Nowork{
            CProgressHUD.showText(text: "无网络")
        }
    }
    
    func zf_playerBackAction() {
        
        self.navigationController?.popViewController(animated: true)
    }
}

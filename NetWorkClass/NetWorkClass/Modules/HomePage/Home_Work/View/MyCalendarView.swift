//
//  MyCalendarView.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/20.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import CVCalendar
import Hue
import Moya
import RxSwift

enum CalendarViewApi {
    case StudentHomeWork
    case TeacherApproveHomeWork
    case TeacherMeHomeWork
    case NOApi
}
enum CalendarNoti {
    //学生首页作业
    case StudentHomeWork
    //老师布置作业
    case TeacherAddHomeWork
    //老师审批
    case TeacherApproveHomeWork
    //老师审批记录
    case TeacherMeHomeWork
}

class MyCalendarView: UIView {

    //星期菜单栏
    private var menuView: CVCalendarMenuView!
    
    //日历主视图
    private var calendarView: CVCalendarView!
    
    let pre = MoyaProvider<HomePageApi>()
    
    let dataSource = NSMutableArray()
    
    var currentCalendar: Calendar!

    let dis = DisposeBag()
    
    var nowdata = Date().dateYearMonthDayString()
    
    fileprivate var Api:CalendarViewApi = .StudentHomeWork
    
    var titleView:MyCalendarTitleView = {
        
        
        let titleView = MyCalendarTitleView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 51))
        return titleView
    }()
    

    init(Api:CalendarViewApi,frame: CGRect) {
        super.init(frame: frame)
        self.Api = Api
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCalendar() {


        self.calendarView.contentController.refreshPresentedMonth()
        //更新日历frame
        self.menuView.commitMenuViewUpdate()
        self.calendarView.commitCalendarViewUpdate()

    }
    
    
    func initView(){
        
        
        self.addSubview(titleView)
        
        
        currentCalendar = Calendar.init(identifier: .gregorian)
        
        //初始化的时候导航栏显示当年当月
        let date = CVDate(date: Date(), calendar: currentCalendar)

        self.titleView.titletext?.text = "\(date.year)"+"年"+"\(date.month)"+"月"
        
        //初始化星期菜单栏
        self.menuView = CVCalendarMenuView(frame: CGRect(x:0, y:self.titleView.frame.maxY, width:self.frame.width, height:25))
        self.menuView.delegate = self
        self.menuView.backgroundColor = CalenderBack
        //初始化日历主视图
        self.calendarView = CVCalendarView(frame: CGRect(x:0, y:self.menuView.frame.maxY, width:self.frame.width,
                                                         height:230))
        self.calendarView.backgroundColor = CalenderBack
        
        self.calendarView.calendarAppearanceDelegate = self

        //星期菜单栏代理
        self.menuView.menuViewDelegate = self
        
        //日历代理
        self.calendarView.calendarDelegate = self
        
        //将菜单视图和日历视图添加到主视图上
        self.addSubview(self.menuView)
        self.addSubview(self.calendarView)
        
        self.titleView.lastbtn?.rx.tap.subscribe({ (event) in
            self.calendarView.loadPreviousView()
        }).disposed(by: dis)
        
        self.titleView.nextbtn?.rx.tap.subscribe({ (event) in
            self.calendarView.loadNextView()
        }).disposed(by: dis)
                
    }
    
    func getDay_StudentHomeWork(date:Date){
        
        self.dataSource.removeAllObjects()
        homePageTool.rx.request(HomePageApi.QueryDayData(date.dateYearMonthDayString())).asObservable().mapArray(Model_Day.self).subscribe(onNext: { (models) in
            
            self.dataSource.addObjects(from: models)
            self.calendarView.contentController.refreshPresentedMonth()
            
        }, onError: { (error) in
            
        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)
    }
    
    func getDay_TeacherApproveHomeWork(date:Date){
        
        self.dataSource.removeAllObjects()
        ApproveTool.rx.request(ApproveApi.QueryDayData(date.dateYearMonthDayString())).asObservable().mapArray(Model_Day.self).subscribe(onNext: { (models) in
            
            self.dataSource.addObjects(from: models)
            self.calendarView.contentController.refreshPresentedMonth()
            
        }, onError: { (error) in
            
        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)
    }
    func getDay_TeacherMeHomeWork(date:Date){
        
        self.dataSource.removeAllObjects()
        TME_Tool.rx.request(TME_API.QueryDayData(date.dateYearMonthDayString())).asObservable().mapArray(Model_Day.self).subscribe(onNext: { (models) in
            
            self.dataSource.addObjects(from: models)
            self.calendarView.contentController.refreshPresentedMonth()
            
        }, onError: { (error) in
            
        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)
    }
    
    func getDate(date:Date){
        if self.Api == .StudentHomeWork {
            getDay_StudentHomeWork(date: date)
        }else if self.Api == .TeacherApproveHomeWork{
            getDay_TeacherApproveHomeWork(date: date)
        }else if self.Api == .TeacherMeHomeWork{
            getDay_TeacherMeHomeWork(date: date)
        }
    }
    
}

extension MyCalendarView : CVCalendarViewDelegate,CVCalendarMenuViewDelegate,CVCalendarViewAppearanceDelegate{
    
    func didShowPreviousMonthView(_ date: Date) {
        
        getDate(date: date)
        print(date)
    }
    
    
    func didShowNextMonthView(_ date: Date) {
        
        getDate(date: date)
        print("翻到了下一个月!")
    }
    
    func dotMarker(shouldShowOnDayView dayView: DayView) -> Bool {
        if !dayView.isHidden && dayView.date != nil {
            //获取该日期视图的年月日
//            let year = dayView.date.year
//            let month = dayView.date.month
            let day = dayView.date.day
            //判断日期是否符合要求
            for model in self.dataSource{
                if day == (model as! Model_Day).day{
                    return true
                }
            }
            
        }
        return false
    }
    
    func dotMarker(colorOnDayView dayView: DayView) -> [UIColor] {
//        switch dayView.date.day {
//        case 1:
//            return [UIColor.orange]
//        case 2:
//            return [UIColor.orange, UIColor.green]
//        default:
//            return [UIColor.orange, UIColor.green, UIColor.blue]
//        }
        return [UIColor.red]
    }
    //视图模式
    func presentationMode() -> CalendarMode {
        //使用周视图
        return .monthView
    }
    
    //每周的第一天
    func firstWeekday() -> Weekday {
        //从星期一开始
        return .sunday
    }
    
    func weekdaySymbolType() -> WeekdaySymbolType {
        return .normal
    }
    
    func presentedDateUpdated(_ date: CVDate) {
        //导航栏显示当前日历的年月
        self.titleView.titletext?.text = "\(date.year)"+"年"+"\(date.month)"+"月"
    }
    
    func dayOfWeekFont() -> UIFont {
        return UIFont.systemFont(ofSize: 12)
    }
    
    //每个日期上面是否添加横线(连在一起就形成每行的分隔线)
    func topMarker(shouldDisplayOnDayView dayView: CVCalendarDayView) -> Bool {
        return false
    }
    
    //切换周的时候日历是否自动选择某一天（本周为今天，其它周为第一天）
    func shouldAutoSelectDayOnWeekChange() -> Bool {
        return false
    }
    
    //日期选择响应
    func didSelectDayView(_ dayView: CVCalendarDayView, animationDidFinish: Bool) {
        //获取日期
        let date = dayView.date.convertedDate(calendar: currentCalendar)!
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy-MM-dd"
        let message = "当前选择的日期是：\(dformatter.string(from: date))"
        //将选择的日期弹出显示
        print(message)

        NotificationCenter.default.post(name: NSNotification.Name.init("nowDate"), object: nil, userInfo: ["date" : dformatter.string(from: date),"role":KUserInfo.UserRole])
        self.nowdata = dformatter.string(from: date)
    }
    
    //星期栏文字颜色
    func dayOfWeekTextColor() -> UIColor {
        return UIColor.init(red: 221/255.0, green: 221/255.0, blue: 221/255.0, alpha: 1)
    }
    
    //星期栏背景颜色
    func dayOfWeekBackGroundColor() -> UIColor {
        return CalenderBack
    }
    
    
    
    //文字字体设置
    func dayLabelFont(by weekDay: Weekday, status: CVStatus, present: CVPresent)
        -> UIFont {
            return UIFont.systemFont(ofSize: 12)
    }
    
//    //文字颜色设置

    func dayLabelColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
        switch (weekDay, status, present) {
//        case (_, .selected, _), (_, .highlighted, _): return WHITEColor
//        case (.sunday, .in, _): return UIColor.red
//        case (.sunday, _, _): return UIColor.green
        case (_, .in, _): return UIColor.white
        default: return UIColor.white
        }

    }
    
    func dayLabelWeekdayInTextColor() -> UIColor {
        return WHITEColor
    }
    
    //文字背景色设置
    func dayLabelBackgroundColor(by weekDay: Weekday, status: CVStatus,
                                 present: CVPresent) -> UIColor? {
        switch (weekDay, status, present) {
//        case (.sunday, .selected, _),
//             (.sunday, .highlighted, _):
        case (_, .selected, _),
             (_, .highlighted, _): return UIColor(hex: "#72c3fe")
        default: return CalenderBack
        }
    }
}

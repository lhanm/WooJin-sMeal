//
//  TodayViewController.swift
//  DaejinMealSwiftWidget
//
//  Created by hanwe on 20/03/2019.
//  Copyright © 2019 hanwe. All rights reserved.
//

import UIKit
import NotificationCenter

enum meal_place_widget {
    case meal_place_widget_student
    case meal_place_widget_professor
    case meal_place_widget_dormitory
}

class TodayViewController: UIViewController, NCWidgetProviding {
    
    //MARK: var
    let g_mealMgr:MealDataManager = MealDataManager.sharedInstance
    let g_getInformationModule:GetInforMationModule = GetInforMationModule.sharedInstance
    var testFlag:Bool = false
    var targetPlace:meal_place_widget = meal_place_widget.meal_place_widget_dormitory
    var nowIndex:Int = 0
    var totalCnt:Int = 0
    
    //MARK: outlet
    @IBOutlet var placeLabel: UILabel!
    @IBOutlet var menuLabel: UILabel!
    @IBOutlet var nextBtn: UIButton!
    @IBOutlet var beforeBtn: UIButton!
    
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.extensionContext?.widgetLargestAvailableDisplayMode = NCWidgetDisplayMode.expanded
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if checkToday(){
            g_getInformationModule.getMealInformation(year: g_mealMgr.todayYear, month: g_mealMgr.todayMonth, day: g_mealMgr.todayDay) {
                DispatchQueue.main.async {
                    self.showContents()
                }
            }
        }
        else{
            print("이미 같다")
            showContents()
        }
        
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.newData)
    }
    
    //MARK: Event
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if (activeDisplayMode == NCWidgetDisplayMode.compact) {
            self.preferredContentSize = maxSize
            print("test1")
        }
        else {
            //expanded
            self.preferredContentSize = CGSize(width: maxSize.width, height: 200)
            print("test2")
        }
    }
    
    //MARK: func
    public func checkToday() -> Bool {
        var resultBool:Bool = false
        let thisWeekArr = Date().getThisWeekStrArr()
        let g_thisWeekData = ThisWeekData.sharedInstance
        g_thisWeekData.thisWeekArr = thisWeekArr
        
        let date = Date()
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MM"
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "dd"
        
        if (g_mealMgr.todayYear == yearFormatter.string(from: date)) &&
            (g_mealMgr.todayMonth == monthFormatter.string(from: date)) &&
            (g_mealMgr.todayDay == dayFormatter.string(from: date)) {
//            print("today \(yearFormatter.string(from: date)) \(monthFormatter.string(from: date)) \(dayFormatter.string(from: date))")
//            print("saved \(g_mealMgr.todayYear) \(g_mealMgr.todayMonth) \(g_mealMgr.todayDay)")
        }
        else{
//            print("today \(yearFormatter.string(from: date)) \(monthFormatter.string(from: date)) \(dayFormatter.string(from: date))")
//            print("saved \(g_mealMgr.todayYear) \(g_mealMgr.todayMonth) \(g_mealMgr.todayDay)")
            g_mealMgr.todayYear = yearFormatter.string(from: date)
            g_mealMgr.todayMonth = monthFormatter.string(from: date)
            g_mealMgr.todayDay = dayFormatter.string(from: date)
            
            resultBool = true
        }
        
        return resultBool
    }
    public func getMealTime() -> meal_time_enum {
        var result:meal_time_enum = meal_time_enum.meal_time_morning
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let morningTime  = dateFormatter.date(from: "\(g_mealMgr.todayYear)-\(g_mealMgr.todayMonth)-\(g_mealMgr.todayDay) 09:30")!
        
        if Int((NSDate().timeIntervalSince(morningTime))/60) > 0 {
            let lunchTime  = dateFormatter.date(from: "\(g_mealMgr.todayYear)-\(g_mealMgr.todayMonth)-\(g_mealMgr.todayDay) 14:00")!
            result = meal_time_enum.meal_time_lunch
            if Int((NSDate().timeIntervalSince(lunchTime))/60) > 0{
                result = meal_time_enum.meal_time_dinner
            }
        }
        
        return result
    }
    
    func showContents() {
        if let userDefaults = UserDefaults(suiteName: "group.com.DaejinMealGroup") {
            let value = userDefaults.string(forKey: "key")
            if value != nil{
                if value! == "student"{
                    self.targetPlace = meal_place_widget.meal_place_widget_student
                    self.placeLabel?.text = "학생회관"
                    if g_mealMgr.todayMealData.professorPlace.count != 0 {
                        let tmpArr:Array<Any> = g_mealMgr.todayMealData.studentPlace[meal_time_enum.meal_time_lunch] as! Array<Any>
                        if tmpArr.count > 0 {
                            totalCnt = tmpArr.count
                            if tmpArr.count <= 1 {
                                self.nextBtn.isHidden = true
                                self.beforeBtn.isHidden = true
                                //                            self.menuLabel?.text = tmpArr[nowIndex]
                            }
                            let tmpDic:Dictionary<String,String> = tmpArr[nowIndex] as! Dictionary<String, String>
                            let keys = Array(tmpDic.keys).sorted()
                            print("keys :\(keys)")
                            self.menuLabel?.text = keys[0] as String
                            
                        }
                        
                    }
                    else {
                        self.menuLabel?.text = " - "
                    }
                }
                else if value! == "dormitory"{
                    self.targetPlace = meal_place_widget.meal_place_widget_dormitory
                    
                    //
                    let nowMealTime:meal_time_enum = getMealTime()
                    if nowMealTime == meal_time_enum.meal_time_morning{
                        self.placeLabel?.text = "생활관(아침)"
                    }
                    else if nowMealTime == meal_time_enum.meal_time_lunch{
                        self.placeLabel?.text = "생활관(점심)"
                    }
                    else if nowMealTime == meal_time_enum.meal_time_dinner{
                        self.placeLabel?.text = "생활관(저녁)"
                    }
                    else{
                        self.placeLabel?.text = "알 수 없는 enum"
                    }
                    if g_mealMgr.todayMealData.dormitory.count != 0 {
                        let tmpArr:Array<Any> = g_mealMgr.todayMealData.dormitory[nowMealTime] as! Array<Any>
                        if tmpArr.count > 0 {
                            totalCnt = tmpArr.count
                            if tmpArr.count <= 1 {
                            }
                            let tmpDic:Dictionary<String,String> = tmpArr[nowIndex] as! Dictionary<String, String>
                            let keys = Array(tmpDic.keys).sorted()
                            self.menuLabel?.text = keys[0] as String
                        }
                    }
                    else {
                        self.menuLabel?.text = " - "
                    }
                }
                else if value! == "professor"{
                    self.targetPlace = meal_place_widget.meal_place_widget_professor
                    self.placeLabel?.text = "교수회관"
                    if g_mealMgr.todayMealData.professorPlace.count != 0 {
                        let tmpArr:Array<Any> = g_mealMgr.todayMealData.professorPlace[meal_time_enum.meal_time_lunch] as! Array<Any>
                        if tmpArr.count > 0 {
                            totalCnt = tmpArr.count
                            if tmpArr.count <= 1 {
                            }
                            let tmpDic:Dictionary<String,String> = tmpArr[nowIndex] as! Dictionary<String, String>
                            let keys = Array(tmpDic.keys).sorted()
                            print("keys :\(keys)")
                            self.menuLabel?.text = keys[0] as String
                            
                        }
                    }
                    else {
                        self.menuLabel?.text = " - "
                    }
                }
                else{
                    
                }
            }
            else{
                self.targetPlace = meal_place_widget.meal_place_widget_student
                self.placeLabel?.text = "학생회관"
                if g_mealMgr.todayMealData.studentPlace.count != 0 {
                    let tmpArr:Array<Any> = g_mealMgr.todayMealData.studentPlace[meal_time_enum.meal_time_lunch] as! Array<Any>
                    if tmpArr.count > 0 {
                        totalCnt = tmpArr.count
                        if tmpArr.count <= 1 {
                            self.nextBtn.isHidden = true
                            self.beforeBtn.isHidden = true
                        }
                        let tmpDic:Dictionary<String,String> = tmpArr[nowIndex] as! Dictionary<String, String>
                        let keys = Array(tmpDic.keys).sorted()
                        print("keys :\(keys)")
                        self.menuLabel?.text = keys[0] as String
                        
                    }
                }
                else {
                    self.menuLabel?.text = " - "
                }
            }
        }
    }
    //MARK: action
    @IBAction func nextAction(_ sender: Any) {
        if self.nowIndex+1 != totalCnt{
            self.nowIndex = self.nowIndex + 1
        }
        showContents()
    }
    @IBAction func beforeAction(_ sender: Any) {
        if self.nowIndex != 0 {
            self.nowIndex = self.nowIndex - 1
        }
        showContents()
    }
    
}

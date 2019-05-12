//
//  ViewController.swift
//  DaejinMealSwift
//
//  Created by hanwe on 09/03/2019.
//  Copyright © 2019 hanwe. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController {
    
    var mealDataKey:String = ""
    var nextDataKeyIndex:Int = 0
    let g_mealMgr:MealDataManager = MealDataManager.sharedInstance
    let g_thisWeekData = ThisWeekData.sharedInstance
    let g_getInformationModule:GetInforMationModule = GetInforMationModule.sharedInstance
    var todayYear:String = ""
    var todayMonth:String = ""
    var todayDay:String = ""
    
    // MARK: IBOutlet
    @IBOutlet var myTableView: UITableView!
    @IBOutlet var mainTableVC: MainTableVC!
    @IBOutlet var adView: GADBannerView!
    //    @IBOutlet var mainTabBar: UITabBar!
    
    //MARK : lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refreshWeekDays()
        g_getInformationModule.getMealInforMationFromAFNetwork(year: self.todayYear,
                                                               month: self.todayMonth,
                                                               day: self.todayDay)
        { (inputArr) in
            self.g_getInformationModule.seperateAndSetData(inputArr)
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        }
        self.mainTableVC.registNib()
        self.mainTableVC.refreshWeekDays()
        initUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "오늘의식단"
        
    }
    
    
    //MARK : func
    
    func initUI() {
//        mainTabBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
//        self.navigationController?.navigationBar.topItem?.title = "오늘의식단"
        adView.adUnitID = "ca-app-pub-7046536274679093/4644567575"
        adView.rootViewController = self
        adView.load(GADRequest())
    }
    public func refreshWeekDays() {
        let thisWeekArr = Date().getThisWeekStrArr()
        print("test \(thisWeekArr)")
        let g_thisWeekData = ThisWeekData.sharedInstance
        g_thisWeekData.thisWeekArr = thisWeekArr
        
        let date = Date()
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MM"
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "dd"
        
        self.todayYear = yearFormatter.string(from: date)
        self.todayMonth = monthFormatter.string(from: date)
        self.todayDay = dayFormatter.string(from: date)
    }
    @IBAction func testAction(_ sender: Any) {
//        g_getInformationModule.getMealInformation(year: self.todayYear, month: self.todayMonth, day: self.todayDay)
    }


}


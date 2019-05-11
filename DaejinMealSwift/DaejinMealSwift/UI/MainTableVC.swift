//
//  MainTableVC.swift
//  DaejinMealSwift
//
//  Created by HanWe Lee on 13/03/2019.
//  Copyright © 2019 hanwe. All rights reserved.
//

import UIKit

class MainTableVC: NSObject {
    // MARK: IBOutlet
    @IBOutlet weak var myTableView: UITableView!
    
    // MARK: var
    var todayYear:String = ""
    var todayMonth:String = ""
    var todayDay:String = ""
    let g_mealMgr:MealDataManager = MealDataManager.sharedInstance
    
    override init() {
        super.init()
    }
    
    public func registNib() {
        let headerNib = UINib.init(nibName: "MainTableViewHeaderFooterView", bundle: Bundle.main)
        if myTableView == nil {
        }
        else{
            myTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "MainTableViewHeaderFooterView")
        }
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
}

// MARK: UITableViewDelegate
extension MainTableVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        print(items[indexPath.row])
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var sectionHeight:CGFloat = 70
        if section == 0 {
            sectionHeight = 70.0
        }//학
        else if section == 1 {
            sectionHeight = 70.0
        }
        else if section == 2 {
            sectionHeight = 35.0
        }
        else if section == 3 {
            sectionHeight = 35.0
        }//기
        else if section == 4 {
            sectionHeight = 70.0
        }//교
        
        
        return sectionHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MainTableViewHeaderFooterView") as! MainTableViewHeaderFooterView
        
        if section == 0 {
            headerView.topLabel?.text = "학생회관"
            headerView.bottomLabel?.text = "점심"
            headerView.bottomLabel?.isHidden = false
            headerView.topImgView?.isHidden = true
            headerView.bottomImgView?.isHidden = false
            headerView.bottomImgView?.image = UIImage(named: "noon")
        }
        else if section == 1 {
            headerView.topLabel?.text = "생활관"
            headerView.bottomLabel?.text = "아침"
            headerView.bottomLabel?.isHidden = false
            headerView.topImgView?.isHidden = true
            headerView.bottomImgView?.isHidden = false
            headerView.bottomImgView?.image = UIImage(named: "sunrise")
        }
        else if section == 2 {
            headerView.topLabel?.text = "점심"
            headerView.bottomLabel?.isHidden = true
            headerView.topImgView?.isHidden = false
            headerView.bottomImgView?.isHidden = true
            headerView.topImgView?.image = UIImage(named: "noon")
        }
        else if section == 3 {
            headerView.topLabel?.text = "저녁"
            headerView.bottomLabel?.isHidden = true
            headerView.topImgView?.isHidden = false
            headerView.bottomImgView?.isHidden = true
            headerView.topImgView?.image = UIImage(named: "sunset")
        }
        else if section == 4 {
            headerView.topLabel?.text = "교수회관"
            headerView.bottomLabel?.text = "점심"
            headerView.bottomLabel?.isHidden = false
            headerView.topImgView?.isHidden = true
            headerView.bottomImgView?.isHidden = false
            headerView.bottomImgView?.image = UIImage(named: "noon")
        }
        headerView.fitLabel()
        return headerView
    }
}

// MARK: UITableViewDataSource
extension MainTableVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnCnt:Int = 1
        var tmpArr:Array<Any>? = nil
        if section == 0 {
            if g_mealMgr.todayMealData.studentPlace[meal_time_enum.meal_time_lunch] != nil {
                tmpArr = (g_mealMgr.todayMealData.studentPlace[meal_time_enum.meal_time_lunch] as! Array<Any>)
                returnCnt = (tmpArr?.count)!
            }
            else {
            }
        }
        else if section == 1 {
            if g_mealMgr.todayMealData.dormitory[meal_time_enum.meal_time_morning] != nil {
                tmpArr = (g_mealMgr.todayMealData.dormitory[meal_time_enum.meal_time_morning] as! Array<Any>)
                returnCnt = (tmpArr?.count)!
            }
            else {
            }
        }
        else if section == 2 {
            if g_mealMgr.todayMealData.dormitory[meal_time_enum.meal_time_lunch] != nil {
                tmpArr = (g_mealMgr.todayMealData.dormitory[meal_time_enum.meal_time_lunch] as! Array<Any>)
                returnCnt = (tmpArr?.count)!
            }
            else {
            }
        }
        else if section == 3 {
            if g_mealMgr.todayMealData.dormitory[meal_time_enum.meal_time_dinner] != nil {
                tmpArr = (g_mealMgr.todayMealData.dormitory[meal_time_enum.meal_time_dinner] as! Array<Any>)
                returnCnt = (tmpArr?.count)!
            }
            else {
            }
        }
        else if section == 4 {
            if g_mealMgr.todayMealData.professorPlace[meal_time_enum.meal_time_lunch] != nil {
                tmpArr = (g_mealMgr.todayMealData.professorPlace[meal_time_enum.meal_time_lunch] as! Array<Any>)
                returnCnt = (tmpArr?.count)!
            }
            else {
            }
        }
        
        return returnCnt
//        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainTableViewCellItemID", for: indexPath) as! MainTableViewCell
//        cell.textLabel?.text = "-"
        let section:Int = indexPath[0]
        let row:Int = indexPath[1]
        if section == 0 {
            if g_mealMgr.todayMealData.studentPlace.count > 0 {
                let tmpArr = g_mealMgr.todayMealData.studentPlace[meal_time_enum.meal_time_lunch] as! Array<Any>
                if tmpArr.count > 0 {
//                    print("tmpArr \(tmpArr)")
                    let tmpDic:Dictionary<String,String> = tmpArr[row] as! Dictionary<String,String>
                    let tmpDicKeys = Array(tmpDic.keys).sorted()
//                    print("tmpDicKeys : \(tmpDicKeys)")
                    cell.menuLabel.text = tmpDicKeys[0]
                    cell.priceLabel.text = tmpDic[tmpDicKeys[0]]
                }
                else{
                }
            }
            else{
                cell.menuLabel.text = "-"
                cell.priceLabel.text = "-"
                print("tmpArr nil")
            }
        }
        else if section == 1 {
            if g_mealMgr.todayMealData.dormitory.count > 0 {
                let tmpArr = g_mealMgr.todayMealData.dormitory[meal_time_enum.meal_time_morning] as! Array<Any>
                if tmpArr.count > 0 {
//                    print("tmpArr \(tmpArr)")
                    let tmpDic:Dictionary<String,String> = tmpArr[row] as! Dictionary<String,String>
                    let tmpDicKeys = Array(tmpDic.keys).sorted()
//                    print("tmpDicKeys : \(tmpDicKeys)")
                    cell.menuLabel.text = tmpDicKeys[0]
                    cell.priceLabel.text = tmpDic[tmpDicKeys[0]]
                }
            }
            else{
                cell.menuLabel.text = "-"
                cell.priceLabel.text = "-"
                print("tmpArr nil")
            }
        }
        else if section == 2 {
            if g_mealMgr.todayMealData.dormitory.count > 0 {
                let tmpArr = g_mealMgr.todayMealData.dormitory[meal_time_enum.meal_time_lunch] as! Array<Any>
                if tmpArr.count > 0 {
//                    print("tmpArr \(tmpArr)")
                    let tmpDic:Dictionary<String,String> = tmpArr[row] as! Dictionary<String,String>
                    let tmpDicKeys = Array(tmpDic.keys).sorted()
//                    print("tmpDicKeys : \(tmpDicKeys)")
                    cell.menuLabel.text = tmpDicKeys[0]
                    cell.priceLabel.text = tmpDic[tmpDicKeys[0]]
                }
            }
            else{
                cell.menuLabel.text = "-"
                cell.priceLabel.text = "-"
                print("tmpArr nil")
            }
        }
        else if section == 3 {
            if g_mealMgr.todayMealData.dormitory.count > 0 {
                let tmpArr = g_mealMgr.todayMealData.dormitory[meal_time_enum.meal_time_dinner] as! Array<Any>
                if tmpArr.count > 0 {
//                    print("tmpArr \(tmpArr)")
                    let tmpDic:Dictionary<String,String> = tmpArr[row] as! Dictionary<String,String>
                    let tmpDicKeys = Array(tmpDic.keys).sorted()
//                    print("tmpDicKeys : \(tmpDicKeys)")
                    cell.menuLabel.text = tmpDicKeys[0]
                    cell.priceLabel.text = tmpDic[tmpDicKeys[0]]
                }
            }
            else{
                cell.menuLabel.text = "-"
                cell.priceLabel.text = "-"
                print("tmpArr nil")
            }
        }
        else if section == 4 {
            if g_mealMgr.todayMealData.professorPlace.count > 0 {
                let tmpArr = g_mealMgr.todayMealData.professorPlace[meal_time_enum.meal_time_lunch] as! Array<Any>
                if tmpArr.count > 0 {
//                    print("tmpArr \(tmpArr)")
                    let tmpDic:Dictionary<String,String> = tmpArr[row] as! Dictionary<String,String>
                    let tmpDicKeys = Array(tmpDic.keys).sorted()
//                    print("tmpDicKeys : \(tmpDicKeys)")
                    cell.menuLabel.text = tmpDicKeys[0]
                    cell.priceLabel.text = tmpDic[tmpDicKeys[0]]
                }
            }
            else{
                cell.menuLabel.text = "-"
                cell.priceLabel.text = "-"
                print("tmpArr nil")
            }
        }
        
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        var resultStr:String = ""
    //        if section == 0{
    //            resultStr = "section1do \n morning"
    //        }
    //        else if section == 1 {
    //            resultStr = "section2s"
    //        }
    //        else if section == 2 {
    //            resultStr = "section3p"
    //        }
    //
    //        return resultStr
    //    }//텍스트 일 경우에만
    
    
}

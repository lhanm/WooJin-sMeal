//
//  WeekTableVC.swift
//  DaejinMealSwift
//
//  Created by hanwe on 17/03/2019.
//  Copyright © 2019 hanwe. All rights reserved.
//

import UIKit

class WeekTableVC: NSObject {
    // MARK: IBOutlet
    @IBOutlet weak var myTableView: UITableView!
    
    // MARK: var
    var todayYear:String = ""
    var todayMonth:String = ""
    var todayDay:String = ""
    let g_mealMgr:MealDataManager = MealDataManager.sharedInstance
    var dayKeys:Array<String>? = nil
    
    override init() {
        super.init()
    }
    
    public func registNib() {
        let headerNib = UINib.init(nibName: "WeekTableViewHeaderFooterView", bundle: Bundle.main)
        if myTableView == nil {
        }
        else{
            myTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "WeekTableViewHeaderFooterView")
            dayKeys = g_mealMgr.oneWeekData.keys.sorted()
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
extension WeekTableVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        print(items[indexPath.row])
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5 * g_mealMgr.oneWeekData.count
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var sectionHeight:CGFloat = 105
        if section%5 == 0 {
            sectionHeight = 105
        }//학
        else if section%5 == 1 {
            sectionHeight = 70
        }
        else if section%5 == 2 {
            sectionHeight = 35
        }
        else if section%5 == 3 {
            sectionHeight = 35
        }//기
        else if section%5 == 4 {
            sectionHeight = 70
        }//교
        
        
        return sectionHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "WeekTableViewHeaderFooterView") as! WeekTableViewHeaderFooterView
        if section%5 == 0 {
//            print("section/5 \(section/5)")
            
//            print("dayKeys : \(dayKeys ?? ["-"])")]
            var dateArr = dayKeys?[section/5].components(separatedBy: "/")
            let dayOftheWeek:String = getDayOfTheWeek(section/5)
            headerView.topLabel?.text = "\(dateArr![0])월 \(dateArr![1])일 \(dayOftheWeek)요일"
            headerView.middleLabel?.text = "학생회관"
            headerView.bottomLabel?.text = "점심"
            headerView.middleLabel.isHidden = false
            headerView.bottomLabel.isHidden = false
            headerView.bottomImgView?.image = UIImage(named: "noon")
            headerView.topImgView?.isHidden = true
            headerView.middleImgView?.isHidden = true
            headerView.bottomImgView?.isHidden = false
        }
        else if section%5 == 1 {
            headerView.topLabel?.text = "생활관"
            headerView.middleLabel?.text = "아침"
            headerView.middleLabel.isHidden = false
            headerView.bottomLabel.isHidden = true
            headerView.middleImgView?.image = UIImage(named: "sunrise")
            headerView.topImgView?.isHidden = true
            headerView.middleImgView?.isHidden = false
            headerView.bottomImgView?.isHidden = true
        }
        else if section%5 == 2 {
            headerView.topLabel?.text = "점심"
            headerView.middleLabel.isHidden = true
            headerView.bottomLabel.isHidden = true
            headerView.topImgView?.image = UIImage(named: "noon")
            headerView.topImgView?.isHidden = false
            headerView.middleImgView?.isHidden = true
            headerView.bottomImgView?.isHidden = true
        }
        else if section%5 == 3 {
            headerView.topLabel?.text = "저녁"
            headerView.middleLabel.isHidden = true
            headerView.bottomLabel.isHidden = true
            headerView.topImgView?.image = UIImage(named: "sunset")
            headerView.topImgView?.isHidden = false
            headerView.middleImgView?.isHidden = true
            headerView.bottomImgView?.isHidden = true
        }
        else if section%5 == 4 {
            headerView.topLabel?.text = "교수회관"
            headerView.middleLabel?.text = "점심"
            headerView.middleLabel.isHidden = false
            headerView.bottomLabel.isHidden = true
            headerView.middleImgView?.image = UIImage(named: "noon")
            headerView.topImgView?.isHidden = true
            headerView.middleImgView?.isHidden = false
            headerView.bottomImgView?.isHidden = true
        }
        headerView.fitLabel()
        return headerView
    }
    
    func getDayOfTheWeek(_ section:Int) ->String {
        var resultStr = ""
        switch section {
        case 0:
            resultStr = "월"
        case 1:
            resultStr = "화"
        case 2:
            resultStr = "수"
        case 3:
            resultStr = "목"
        case 4:
            resultStr = "금"
        case 5:
            resultStr = "토"
        default:
            resultStr = ""
        }
        return resultStr
    }
}

// MARK: UITableViewDataSource
extension WeekTableVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnCnt:Int = 1
        var tmpArr:Array<Any>? = nil
        if section%5 == 0 {
            if g_mealMgr.oneWeekData[dayKeys![section/5] as String]!.studentPlace[meal_time_enum.meal_time_lunch] != nil{
                tmpArr = (g_mealMgr.oneWeekData[dayKeys![section/5] as String]!.studentPlace[meal_time_enum.meal_time_lunch] as! Array<Any>)
                    returnCnt = (tmpArr?.count)!
//                print("returnCnt \(returnCnt)")
            }
            else{
                
            }
        }
        else if section%5 == 1 {
            if g_mealMgr.oneWeekData[dayKeys![section/5] as String]!.dormitory[meal_time_enum.meal_time_morning] != nil {
                tmpArr = (g_mealMgr.oneWeekData[dayKeys![section/5] as String]!.dormitory[meal_time_enum.meal_time_morning] as! Array<Any>)
                returnCnt = (tmpArr?.count)!
            }
            else {
                
            }
        }
        else if section%5 == 2 {
            if g_mealMgr.oneWeekData[dayKeys![section/5] as String]!.dormitory[meal_time_enum.meal_time_lunch] != nil {
                tmpArr = (g_mealMgr.oneWeekData[dayKeys![section/5] as String]!.dormitory[meal_time_enum.meal_time_lunch] as! Array<Any>)
                returnCnt = (tmpArr?.count)!
            }
            else {
                
            }
        }
        else if section%5 == 3 {
            if g_mealMgr.oneWeekData[dayKeys![section/5] as String]!.dormitory[meal_time_enum.meal_time_dinner] != nil {
                tmpArr = (g_mealMgr.oneWeekData[dayKeys![section/5] as String]!.dormitory[meal_time_enum.meal_time_dinner] as! Array<Any>)
                returnCnt = (tmpArr?.count)!
            }
            else {
                
            }
        }
        else if section%5 == 4 {
            if g_mealMgr.oneWeekData[dayKeys![section/5] as String]!.professorPlace[meal_time_enum.meal_time_lunch] != nil {
                tmpArr = (g_mealMgr.oneWeekData[dayKeys![section/5] as String]!.professorPlace[meal_time_enum.meal_time_lunch] as! Array<Any>)
                returnCnt = (tmpArr?.count)!
            }
            else {
                
            }
        }
        
        return returnCnt
        //        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weekTableViewCellItemID", for: indexPath) as! WeekTableViewCell
        //        cell.textLabel?.text = "-"
        let section:Int = indexPath[0]
        let row:Int = indexPath[1]
        if section%5 == 0 {
//            if g_mealMgr.oneWeekData[dayKeys![section/5] as String]!.studentPlace[meal_time_enum.meal_time_lunch]
            if g_mealMgr.oneWeekData[dayKeys![section/5] as String]!.studentPlace.count > 0 {
                let tmpArr = g_mealMgr.oneWeekData[dayKeys![section/5] as String]!.studentPlace[meal_time_enum.meal_time_lunch] as! Array<Any>
                if tmpArr.count > 0 {
                    let tmpDic:Dictionary<String,String> = tmpArr[row] as! Dictionary<String,String>
                    let tmpDicKeys = Array(tmpDic.keys).sorted()
                    //                    print("tmpDicKeys : \(tmpDicKeys)")
                    cell.menuLabel.text = tmpDicKeys[0]
                    cell.priceLabel.text = tmpDic[tmpDicKeys[0]]
                }
                else{
                    
                }
            }
            else {
                cell.menuLabel.text = "-"
                cell.priceLabel.text = "-"
            }
//            if g_mealMgr.todayMealData.studentPlace.count > 0 {
//                let tmpArr = g_mealMgr.todayMealData.studentPlace[meal_time_enum.meal_time_lunch] as! Array<Any>
//                if tmpArr.count > 0 {
//                    //                    print("tmpArr \(tmpArr)")
//                    let tmpDic:Dictionary<String,String> = tmpArr[row] as! Dictionary<String,String>
//                    let tmpDicKeys = Array(tmpDic.keys).sorted()
//                    //                    print("tmpDicKeys : \(tmpDicKeys)")
//                    cell.menuLabel.text = tmpDicKeys[0]
//                    cell.priceLabel.text = tmpDic[tmpDicKeys[0]]
//                }
//                else{
//                }
//            }
//            else{
//                cell.menuLabel.text = "-"
//                cell.priceLabel.text = "-"
//                print("tmpArr nil")
//            }
        }
        else if section%5 == 1 {
            if g_mealMgr.oneWeekData[dayKeys![section/5] as String]!.dormitory.count > 0 {
                let tmpArr = g_mealMgr.oneWeekData[dayKeys![section/5] as String]!.dormitory[meal_time_enum.meal_time_morning] as! Array<Any>
                if tmpArr.count > 0 {
                    let tmpDic:Dictionary<String,String> = tmpArr[row] as! Dictionary<String,String>
                    let tmpDicKeys = Array(tmpDic.keys).sorted()
                    //                    print("tmpDicKeys : \(tmpDicKeys)")
                    cell.menuLabel.text = tmpDicKeys[0]
                    cell.priceLabel.text = tmpDic[tmpDicKeys[0]]
                }
                else{
                    
                }
            }
            else {
                cell.menuLabel.text = "-"
                cell.priceLabel.text = "-"
            }
//            if g_mealMgr.todayMealData.dormitory.count > 0 {
//                let tmpArr = g_mealMgr.todayMealData.dormitory[meal_time_enum.meal_time_morning] as! Array<Any>
//                if tmpArr.count > 0 {
//                    //                    print("tmpArr \(tmpArr)")
//                    let tmpDic:Dictionary<String,String> = tmpArr[row] as! Dictionary<String,String>
//                    let tmpDicKeys = Array(tmpDic.keys).sorted()
//                    //                    print("tmpDicKeys : \(tmpDicKeys)")
//                    cell.menuLabel.text = tmpDicKeys[0]
//                    cell.priceLabel.text = tmpDic[tmpDicKeys[0]]
//                }
//            }
//            else{
//                cell.menuLabel.text = "-"
//                cell.priceLabel.text = "-"
//                print("tmpArr nil")
//            }
        }
        else if section%5 == 2 {
            if g_mealMgr.oneWeekData[dayKeys![section/5] as String]!.dormitory.count > 0 {
                let tmpArr = g_mealMgr.oneWeekData[dayKeys![section/5] as String]!.dormitory[meal_time_enum.meal_time_lunch] as! Array<Any>
                if tmpArr.count > 0 {
                    let tmpDic:Dictionary<String,String> = tmpArr[row] as! Dictionary<String,String>
                    let tmpDicKeys = Array(tmpDic.keys).sorted()
                    //                    print("tmpDicKeys : \(tmpDicKeys)")
                    cell.menuLabel.text = tmpDicKeys[0]
                    cell.priceLabel.text = tmpDic[tmpDicKeys[0]]
                }
                else{
                    
                }
            }
            else {
                cell.menuLabel.text = "-"
                cell.priceLabel.text = "-"
            }
//            if g_mealMgr.todayMealData.dormitory.count > 0 {
//                let tmpArr = g_mealMgr.todayMealData.dormitory[meal_time_enum.meal_time_lunch] as! Array<Any>
//                if tmpArr.count > 0 {
//                    //                    print("tmpArr \(tmpArr)")
//                    let tmpDic:Dictionary<String,String> = tmpArr[row] as! Dictionary<String,String>
//                    let tmpDicKeys = Array(tmpDic.keys).sorted()
//                    //                    print("tmpDicKeys : \(tmpDicKeys)")
//                    cell.menuLabel.text = tmpDicKeys[0]
//                    cell.priceLabel.text = tmpDic[tmpDicKeys[0]]
//                }
//            }
//            else{
//                cell.menuLabel.text = "-"
//                cell.priceLabel.text = "-"
//                print("tmpArr nil")
//            }
        }
        else if section%5 == 3 {
//            if g_mealMgr.todayMealData.dormitory.count > 0 {
//                let tmpArr = g_mealMgr.todayMealData.dormitory[meal_time_enum.meal_time_dinner] as! Array<Any>
//                if tmpArr.count > 0 {
//                    //                    print("tmpArr \(tmpArr)")
//                    let tmpDic:Dictionary<String,String> = tmpArr[row] as! Dictionary<String,String>
//                    let tmpDicKeys = Array(tmpDic.keys).sorted()
//                    //                    print("tmpDicKeys : \(tmpDicKeys)")
//                    cell.menuLabel.text = tmpDicKeys[0]
//                    cell.priceLabel.text = tmpDic[tmpDicKeys[0]]
//                }
//            }
//            else{
//                cell.menuLabel.text = "-"
//                cell.priceLabel.text = "-"
//                print("tmpArr nil")
//            }
            if g_mealMgr.oneWeekData[dayKeys![section/5] as String]!.dormitory.count > 0 {
                let tmpArr = g_mealMgr.oneWeekData[dayKeys![section/5] as String]!.dormitory[meal_time_enum.meal_time_dinner] as! Array<Any>
                if tmpArr.count > 0 {
                    let tmpDic:Dictionary<String,String> = tmpArr[row] as! Dictionary<String,String>
                    let tmpDicKeys = Array(tmpDic.keys).sorted()
                    //                    print("tmpDicKeys : \(tmpDicKeys)")
                    cell.menuLabel.text = tmpDicKeys[0]
                    cell.priceLabel.text = tmpDic[tmpDicKeys[0]]
                }
                else{
                    
                }
            }
            else {
                cell.menuLabel.text = "-"
                cell.priceLabel.text = "-"
            }
        }
        else if section%5 == 4 {
            if g_mealMgr.oneWeekData[dayKeys![section/5] as String]!.professorPlace.count > 0 {
                let tmpArr = g_mealMgr.oneWeekData[dayKeys![section/5] as String]!.professorPlace[meal_time_enum.meal_time_lunch] as! Array<Any>
                if tmpArr.count > 0 {
                    let tmpDic:Dictionary<String,String> = tmpArr[row] as! Dictionary<String,String>
                    let tmpDicKeys = Array(tmpDic.keys).sorted()
                    //                    print("tmpDicKeys : \(tmpDicKeys)")
                    cell.menuLabel.text = tmpDicKeys[0]
                    cell.priceLabel.text = tmpDic[tmpDicKeys[0]]
                }
                else{
                    
                }
            }
            else {
                cell.menuLabel.text = "-"
                cell.priceLabel.text = "-"
            }
//            if g_mealMgr.todayMealData.professorPlace.count > 0 {
//                let tmpArr = g_mealMgr.todayMealData.professorPlace[meal_time_enum.meal_time_lunch] as! Array<Any>
//                if tmpArr.count > 0 {
//                    //                    print("tmpArr \(tmpArr)")
//                    let tmpDic:Dictionary<String,String> = tmpArr[row] as! Dictionary<String,String>
//                    let tmpDicKeys = Array(tmpDic.keys).sorted()
//                    //                    print("tmpDicKeys : \(tmpDicKeys)")
//                    cell.menuLabel.text = tmpDicKeys[0]
//                    cell.priceLabel.text = tmpDic[tmpDicKeys[0]]
//                }
//            }
//            else{
//                cell.menuLabel.text = "-"
//                cell.priceLabel.text = "-"
//                print("tmpArr nil")
//            }
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


//
//  GetInforMationModule.swift
//  DaejinMealSwift
//
//  Created by HanWe Lee on 13/03/2019.
//  Copyright © 2019 hanwe. All rights reserved.
//

import UIKit
import Alamofire

class GetInforMationModule: NSObject {
    
    static let sharedInstance = GetInforMationModule()
    var mealDataKey:String = ""
    var nextDataKeyIndex:Int = 0
    let g_mealMgr:MealDataManager = MealDataManager.sharedInstance
    let g_thisWeekData = ThisWeekData.sharedInstance
    
    private override init()
    {
    }
    
    public func getMealInforMationFromAFNetwork(year inputYear:String, month inputMonth:String,day inputDay:String,cloure: @escaping (Array<String>) -> ()){
        Alamofire.request("\(WebAPIDefine.DAEJIN_GET_MEAL_DATA_API_DEFINE)?\(WebAPIDefine.DAEJIN_GET_MEAL_DATA_API_RQ_PARAM_YEAR_DEFINE)=\(inputYear)&\(WebAPIDefine.DAEJIN_GET_MEAL_DATA_API_RQ_PARAM_MONTH_DEFINE)=\(inputMonth)&\(WebAPIDefine.DAEJIN_GET_MEAL_DATA_API_RQ_PARAM_DAY_DEFINE)=\(inputDay)"
            , method: .get, parameters: nil, encoding:URLEncoding.default)
            .responseString { (response) in
//                print("response :\(response)")
                switch response.result{
                case .success:
                    let strData:Data = Data(response.value!.utf8)
                    let parser:TFHpple = TFHpple(htmlData: strData, encoding: "utf-8")
                    let elements:Array = parser.search(withXPathQuery: "//td")
                    var dataArr:Array<String> = Array()
                    for i in 0 ..< elements.count {
                        let e:TFHppleElement = elements[i] as! TFHppleElement
                        if e.raw.contains("&#13;"){
                            continue
                        }
                        if e.raw.contains("<a href="){
                            continue
                        }
                        var elementStr:String = e.raw.removeTDTag()
//                        print("elementStr:\(elementStr)")
                        elementStr = elementStr.replacingOccurrences(of: "&amp;", with: "&", options: .literal, range: nil)
                        dataArr.append(elementStr)
                    }
                    cloure(dataArr)//closure호출
                    break
                case .failure(let error):
                    print("error :\(error)")
                    break
                }
        }
    }
    
    public func seperateAndSetData(_ inputArr:Array<String>) {
        //        print("test \(inputArr)")
        
        for i in 0 ..< inputArr.count {
            if inputArr[i] as String == KeywordDefine.PROFESSOR_PLACE_DEFINE {
                if inputArr[i+1] as String == KeywordDefine.MORNING_MEAL_DEFINE {
                    var oneMeal:Dictionary<String,String> = Dictionary()
                    var oneMealArr:Array<Any> = Array()
                    for j in i+2 ..< inputArr.count {
                        if inputArr[j] as String == KeywordDefine.PROFESSOR_PLACE_DEFINE  ||
                            inputArr[j] as String == KeywordDefine.STUDENTS_PLACE_DEFINE ||
                            inputArr[j] as String == KeywordDefine.DORMITORY_DEFINE ||
                            inputArr[j] as String == KeywordDefine.MORNING_MEAL_DEFINE ||
                            inputArr[j] as String == KeywordDefine.LUNCH_MEAL_DEFINE ||
                            inputArr[j] as String == KeywordDefine.DINNER_MEAL_DEFINE ||
                            inputArr[j] as String == "<td/>"{
                            break
                        }
                        else {
                            if inputArr[j].hasSuffix("원"){
                                continue
                            }
                            oneMeal.removeAll()
                            oneMeal[inputArr[j]] = inputArr[j+1]
                            //                            print("oneMeal: \(oneMeal)")
                            oneMealArr.append(oneMeal)
                            
                        }
                    }
                    if(mealDataKey == ""){
                        g_mealMgr.todayMealData.professorPlace[meal_time_enum.meal_time_morning] = oneMealArr
                    }
                    else{
                        if g_mealMgr.oneWeekData[mealDataKey] == nil {
                            g_mealMgr.oneWeekData[mealDataKey] = MealData()
                        }
                        g_mealMgr.oneWeekData[mealDataKey]?.professorPlace[meal_time_enum.meal_time_morning] = oneMealArr
                    }
                }
                else if inputArr[i+1] as String == KeywordDefine.LUNCH_MEAL_DEFINE {
                    var oneMeal:Dictionary<String,String> = Dictionary()
                    var oneMealArr:Array<Any> = Array()
                    for j in i+2 ..< inputArr.count {
                        if inputArr[j] as String == KeywordDefine.PROFESSOR_PLACE_DEFINE  ||
                            inputArr[j] as String == KeywordDefine.STUDENTS_PLACE_DEFINE ||
                            inputArr[j] as String == KeywordDefine.DORMITORY_DEFINE ||
                            inputArr[j] as String == KeywordDefine.MORNING_MEAL_DEFINE ||
                            inputArr[j] as String == KeywordDefine.LUNCH_MEAL_DEFINE ||
                            inputArr[j] as String == KeywordDefine.DINNER_MEAL_DEFINE ||
                            inputArr[j] as String == "<td/>"{
                            break
                        }
                        else {
                            if inputArr[j].hasSuffix("원"){
                                continue
                            }
                            oneMeal.removeAll()
                            oneMeal[inputArr[j]] = inputArr[j+1]
                            //                            print("oneMeal: \(oneMeal)")
                            oneMealArr.append(oneMeal)
                        }
                    }
                    if(mealDataKey == ""){
                        g_mealMgr.todayMealData.professorPlace[meal_time_enum.meal_time_lunch] = oneMealArr
                    }
                    else{
                        if g_mealMgr.oneWeekData[mealDataKey] == nil {
                            g_mealMgr.oneWeekData[mealDataKey] = MealData()
                        }
                        g_mealMgr.oneWeekData[mealDataKey]?.professorPlace[meal_time_enum.meal_time_lunch] = oneMealArr
                    }
                }
                else if inputArr[i+1] as String == KeywordDefine.DINNER_MEAL_DEFINE {
                    var oneMeal:Dictionary<String,String> = Dictionary()
                    var oneMealArr:Array<Any> = Array()
                    for j in i+2 ..< inputArr.count {
                        if inputArr[j] as String == KeywordDefine.PROFESSOR_PLACE_DEFINE  ||
                            inputArr[j] as String == KeywordDefine.STUDENTS_PLACE_DEFINE ||
                            inputArr[j] as String == KeywordDefine.DORMITORY_DEFINE ||
                            inputArr[j] as String == KeywordDefine.MORNING_MEAL_DEFINE ||
                            inputArr[j] as String == KeywordDefine.LUNCH_MEAL_DEFINE ||
                            inputArr[j] as String == KeywordDefine.DINNER_MEAL_DEFINE ||
                            inputArr[j] as String == "<td/>"{
                            break
                        }
                        else {
                            if inputArr[j].hasSuffix("원"){
                                continue
                            }
                            oneMeal.removeAll()
                            oneMeal[inputArr[j]] = inputArr[j+1]
                            //                            print("oneMeal: \(oneMeal)")
                            oneMealArr.append(oneMeal)
                        }
                    }
                    if(mealDataKey == ""){
                        g_mealMgr.todayMealData.professorPlace[meal_time_enum.meal_time_dinner] = oneMealArr
                    }
                    else{
                        if g_mealMgr.oneWeekData[mealDataKey] == nil {
                            g_mealMgr.oneWeekData[mealDataKey] = MealData()
                        }
                        g_mealMgr.oneWeekData[mealDataKey]?.professorPlace[meal_time_enum.meal_time_dinner] = oneMealArr
                    }
                }
            }
            else if inputArr[i] as String == KeywordDefine.STUDENTS_PLACE_DEFINE {
                if inputArr[i+1] as String == KeywordDefine.MORNING_MEAL_DEFINE {
                    var oneMeal:Dictionary<String,String> = Dictionary()
                    var oneMealArr:Array<Any> = Array()
                    for j in i+2 ..< inputArr.count {
                        if inputArr[j] as String == KeywordDefine.PROFESSOR_PLACE_DEFINE  ||
                            inputArr[j] as String == KeywordDefine.STUDENTS_PLACE_DEFINE ||
                            inputArr[j] as String == KeywordDefine.DORMITORY_DEFINE ||
                            inputArr[j] as String == KeywordDefine.MORNING_MEAL_DEFINE ||
                            inputArr[j] as String == KeywordDefine.LUNCH_MEAL_DEFINE ||
                            inputArr[j] as String == KeywordDefine.DINNER_MEAL_DEFINE ||
                            inputArr[j] as String == "<td/>"{
                            break
                        }
                        else {
                            if inputArr[j].hasSuffix("원"){
                                continue
                            }
                            oneMeal.removeAll()
                            oneMeal[inputArr[j]] = inputArr[j+1]
                            //                            print("oneMeal: \(oneMeal)")
                            oneMealArr.append(oneMeal)
                        }
                    }
                    if(mealDataKey == ""){
                        g_mealMgr.todayMealData.studentPlace[meal_time_enum.meal_time_morning] = oneMealArr
                    }
                    else{
                        if g_mealMgr.oneWeekData[mealDataKey] == nil {
                            g_mealMgr.oneWeekData[mealDataKey] = MealData()
                        }
                        g_mealMgr.oneWeekData[mealDataKey]?.studentPlace[meal_time_enum.meal_time_morning] = oneMealArr
                    }
                }
                else if inputArr[i+1] as String == KeywordDefine.LUNCH_MEAL_DEFINE {
                    var oneMeal:Dictionary<String,String> = Dictionary()
                    var oneMealArr:Array<Any> = Array()
                    for j in i+2 ..< inputArr.count {
                        if inputArr[j] as String == KeywordDefine.PROFESSOR_PLACE_DEFINE  ||
                            inputArr[j] as String == KeywordDefine.STUDENTS_PLACE_DEFINE ||
                            inputArr[j] as String == KeywordDefine.DORMITORY_DEFINE ||
                            inputArr[j] as String == KeywordDefine.MORNING_MEAL_DEFINE ||
                            inputArr[j] as String == KeywordDefine.LUNCH_MEAL_DEFINE ||
                            inputArr[j] as String == KeywordDefine.DINNER_MEAL_DEFINE ||
                            inputArr[j] as String == "<td/>"{
                            break
                        }
                        else {
                            if inputArr[j].hasSuffix("원"){
                                continue
                            }
                            oneMeal.removeAll()
                            oneMeal[inputArr[j]] = inputArr[j+1]
                            //                            print("oneMeal: \(oneMeal)")
                            oneMealArr.append(oneMeal)
                        }
                    }
                    if(mealDataKey == ""){
                        g_mealMgr.todayMealData.studentPlace[meal_time_enum.meal_time_lunch] = oneMealArr
                    }
                    else{
                        if g_mealMgr.oneWeekData[mealDataKey] == nil {
                            g_mealMgr.oneWeekData[mealDataKey] = MealData()
                        }
                        g_mealMgr.oneWeekData[mealDataKey]?.studentPlace[meal_time_enum.meal_time_lunch] = oneMealArr
                    }
                }
                else if inputArr[i+1] as String == KeywordDefine.DINNER_MEAL_DEFINE {
                    var oneMeal:Dictionary<String,String> = Dictionary()
                    var oneMealArr:Array<Any> = Array()
                    for j in i+2 ..< inputArr.count {
                        if inputArr[j] as String == KeywordDefine.PROFESSOR_PLACE_DEFINE  ||
                            inputArr[j] as String == KeywordDefine.STUDENTS_PLACE_DEFINE ||
                            inputArr[j] as String == KeywordDefine.DORMITORY_DEFINE ||
                            inputArr[j] as String == KeywordDefine.MORNING_MEAL_DEFINE ||
                            inputArr[j] as String == KeywordDefine.LUNCH_MEAL_DEFINE ||
                            inputArr[j] as String == KeywordDefine.DINNER_MEAL_DEFINE ||
                            inputArr[j] as String == "<td/>"{
                            break
                        }
                        else {
                            if inputArr[j].hasSuffix("원"){
                                continue
                            }
                            oneMeal.removeAll()
                            oneMeal[inputArr[j]] = inputArr[j+1]
                            //                            print("oneMeal: \(oneMeal)")
                            oneMealArr.append(oneMeal)
                        }
                    }
                    if(mealDataKey == ""){
                        g_mealMgr.todayMealData.studentPlace[meal_time_enum.meal_time_dinner] = oneMealArr
                    }
                    else{
                        if g_mealMgr.oneWeekData[mealDataKey] == nil {
                            g_mealMgr.oneWeekData[mealDataKey] = MealData()
                        }
                        g_mealMgr.oneWeekData[mealDataKey]?.studentPlace[meal_time_enum.meal_time_dinner] = oneMealArr
                    }
                }
            }
            else if inputArr[i] as String == KeywordDefine.DORMITORY_DEFINE {
                if inputArr[i+1] as String == KeywordDefine.MORNING_MEAL_DEFINE {
                    var oneMeal:Dictionary<String,String> = Dictionary()
                    var oneMealArr:Array<Any> = Array()
                    for j in i+2 ..< inputArr.count {
                        if inputArr[j] as String == KeywordDefine.PROFESSOR_PLACE_DEFINE  ||
                            inputArr[j] as String == KeywordDefine.STUDENTS_PLACE_DEFINE ||
                            inputArr[j] as String == KeywordDefine.DORMITORY_DEFINE ||
                            inputArr[j] as String == KeywordDefine.MORNING_MEAL_DEFINE ||
                            inputArr[j] as String == KeywordDefine.LUNCH_MEAL_DEFINE ||
                            inputArr[j] as String == KeywordDefine.DINNER_MEAL_DEFINE ||
                            inputArr[j] as String == "<td/>"{
                            break
                        }
                        else {
                            if inputArr[j].hasSuffix("원"){
                                continue
                            }
                            oneMeal.removeAll()
                            oneMeal[inputArr[j]] = inputArr[j+1]
                            //                            print("oneMeal: \(oneMeal)")
                            oneMealArr.append(oneMeal)
                            
                        }
                    }
                    if(mealDataKey == ""){
                        g_mealMgr.todayMealData.dormitory[meal_time_enum.meal_time_morning] = oneMealArr
                    }
                    else{
                        if g_mealMgr.oneWeekData[mealDataKey] == nil {
                            g_mealMgr.oneWeekData[mealDataKey] = MealData()
                        }
                        g_mealMgr.oneWeekData[mealDataKey]?.dormitory[meal_time_enum.meal_time_morning] = oneMealArr
                    }
                }
                else if inputArr[i+1] as String == KeywordDefine.LUNCH_MEAL_DEFINE {
                    var oneMeal:Dictionary<String,String> = Dictionary()
                    var oneMealArr:Array<Any> = Array()
                    for j in i+2 ..< inputArr.count {
                        if inputArr[j] as String == KeywordDefine.PROFESSOR_PLACE_DEFINE  ||
                            inputArr[j] as String == KeywordDefine.STUDENTS_PLACE_DEFINE ||
                            inputArr[j] as String == KeywordDefine.DORMITORY_DEFINE ||
                            inputArr[j] as String == KeywordDefine.MORNING_MEAL_DEFINE ||
                            inputArr[j] as String == KeywordDefine.LUNCH_MEAL_DEFINE ||
                            inputArr[j] as String == KeywordDefine.DINNER_MEAL_DEFINE ||
                            inputArr[j] as String == "<td/>"{
                            break
                        }
                        else {
                            if inputArr[j].hasSuffix("원"){
                                continue
                            }
                            oneMeal.removeAll()
                            oneMeal[inputArr[j]] = inputArr[j+1]
                            //                            print("oneMeal: \(oneMeal)")
                            oneMealArr.append(oneMeal)
                            
                        }
                    }
                    if(mealDataKey == ""){
                        g_mealMgr.todayMealData.dormitory[meal_time_enum.meal_time_lunch] = oneMealArr
                    }
                    else{
                        if g_mealMgr.oneWeekData[mealDataKey] == nil {
                            g_mealMgr.oneWeekData[mealDataKey] = MealData()
                        }
                        g_mealMgr.oneWeekData[mealDataKey]?.dormitory[meal_time_enum.meal_time_lunch] = oneMealArr
                    }
                }
                else if inputArr[i+1] as String == KeywordDefine.DINNER_MEAL_DEFINE {
                    var oneMeal:Dictionary<String,String> = Dictionary()
                    var oneMealArr:Array<Any> = Array()
                    for j in i+2 ..< inputArr.count {
                        if inputArr[j] as String == KeywordDefine.PROFESSOR_PLACE_DEFINE  ||
                            inputArr[j] as String == KeywordDefine.STUDENTS_PLACE_DEFINE ||
                            inputArr[j] as String == KeywordDefine.DORMITORY_DEFINE ||
                            inputArr[j] as String == KeywordDefine.MORNING_MEAL_DEFINE ||
                            inputArr[j] as String == KeywordDefine.LUNCH_MEAL_DEFINE ||
                            inputArr[j] as String == KeywordDefine.DINNER_MEAL_DEFINE ||
//                            inputArr[j+1] as String == KeywordDefine.PROFESSOR_PLACE_DEFINE ||
                            inputArr[j] as String == "<td/>"{
                            break
                        }
                        else {
                            if j+1 < inputArr.count{
                                if inputArr[j+1] as String == KeywordDefine.PROFESSOR_PLACE_DEFINE{
                                    continue;
                                }
                                if inputArr[j+1] as String == KeywordDefine.DORMITORY_DEFINE{
                                    continue;
                                }
                                if inputArr[j+1] as String == KeywordDefine.STUDENTS_PLACE_DEFINE{
                                    continue;
                                }
                            }
                            if inputArr[j].hasSuffix("원"){
                                continue
                            }
                            oneMeal.removeAll()
                            oneMeal[inputArr[j]] = inputArr[j+1]
                            print("oneMeal: \(oneMeal)")
                            oneMealArr.append(oneMeal)
                            
                        }
                    }
                    if(mealDataKey == ""){
                        g_mealMgr.todayMealData.dormitory[meal_time_enum.meal_time_dinner] = oneMealArr
                    }
                    else{
                        if g_mealMgr.oneWeekData[mealDataKey] == nil {
                            g_mealMgr.oneWeekData[mealDataKey] = MealData()
                        }
                        g_mealMgr.oneWeekData[mealDataKey]?.dormitory[meal_time_enum.meal_time_dinner] = oneMealArr
                    }
                }
            }
            else if inputArr[i] as String == "<td/>" {
                if i == inputArr.count-1 {
                    print("seperate end")
                    break
                }
                else{
                    if !(inputArr[i+1] as String).hasSuffix("원"){//서버에서 데이터를 이상하게 내려주는경우가 있음. 원으로 끝날경우 데이터키로 정하지 않음.
                        mealDataKey = inputArr[i+1]
                    }
                    
                    if g_thisWeekData.thisWeekArr![0] != mealDataKey {
                        print("unexpected case mealDataKey wrong")
                    }
                    else{
                        nextDataKeyIndex = nextDataKeyIndex + 1
                    }
                }
            }
            else if inputArr[i] as String == g_thisWeekData.thisWeekArr![nextDataKeyIndex] {
                if (g_thisWeekData.thisWeekArr?.count)! > nextDataKeyIndex+1 {
                    mealDataKey = g_thisWeekData.thisWeekArr![nextDataKeyIndex]
                    nextDataKeyIndex = nextDataKeyIndex + 1
                    print("new key \(mealDataKey)")
                }
            }
        }
//        print("test: \(g_mealMgr.todayMealData.professorPlace)")
//        print("test2: \(g_mealMgr.todayMealData.studentPlace)")
//        print("test3: \(g_mealMgr.todayMealData.dormitory)")
    }
}

//
//  GetInforMationModule.swift
//  DaejinMealSwift
//
//  Created by HanWe Lee on 13/03/2019.
//  Copyright © 2019 hanwe. All rights reserved.
//

import UIKit

class GetInforMationModule: NSObject {
    
    static let sharedInstance = GetInforMationModule()
    var mealDataKey:String = ""
    var nextDataKeyIndex:Int = 0
    let g_mealMgr:MealDataManager = MealDataManager.sharedInstance
    let g_thisWeekData = ThisWeekData.sharedInstance
    
    private override init()
    {
    }
    
    public func getMealInformation(year inputYear:String, month inputMonth:String,day inputDay:String,cloure: @escaping () -> ()) {
        // 1. 전송할 값 준비
        //        let userId = (self.userId.text)!
        //        let name = (self.name.text)!
        //        let param = ["userId": userId, "name": name] // JSON 객체로 변환할 딕셔너리 준비
        //        let param = Dictionary<String, Any>()
        //        let paramData = try! JSONSerialization.data(withJSONObject: param, options: [])
        // 2. URL 객체 정의
        //        let url = URL(string: "http://www.daejin.ac.kr/front/commonsmenulist.do?rYear=2018&rMonth=9&rDay=18");
        //        print("http://www.daejin.ac.kr/front/commonsmenulist.do?rYear=\(inputYear)&rMonth=\(inputMonth)&rDay=\(inputDay)")
        let url = URL(string: "http://www.daejin.ac.kr/front/commonsmenulist.do?rYear=\(inputYear)&rMonth=\(inputMonth)&rDay=\(inputDay)");
        //        let url = URL(string: "https://www.naver.com")
        // 3. URLRequest 객체 정의 및 요청 내용 담기
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        //        request.httpBody = paramData
        request.timeoutInterval = 10
        // 4. HTTP 메시지에 포함될 헤더 설정
        request.addValue("application/xml, text/html, */*", forHTTPHeaderField: "Accept")
        
        // 5. URLSession 객체를 통해 전송 및 응답값 처리 로직 작성
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            let responseString = String(data: data, encoding: String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(0x0422)))
            //print("responseString = \(responseString)")
            let strData = Data(responseString!.utf8)
            let parser:TFHpple = TFHpple(htmlData: strData, encoding: "utf-8")
            let elements:Array = parser.search(withXPathQuery: "//td")
            var dataArr:Array<String> = Array()
            for i in 0 ..< elements.count {
                let e:TFHppleElement = elements[i] as! TFHppleElement
                //                print("raw \(i): \(e.raw!)")
                if e.raw.contains("&#13;"){
                    continue
                }
                if e.raw.contains("<a href="){
                    continue
                }
                var elementStr:String = e.raw.removeTDTag()
                print("elementStr:\(elementStr)")
                elementStr = elementStr.replacingOccurrences(of: "&amp;", with: "&", options: .literal, range: nil)
                dataArr.append(elementStr)
            }
            self.seperateAndSetData(dataArr)
            //closure호출
            cloure()
        }
        // 6. POST 전송
        task.resume()
    }
    func seperateAndSetData(_ inputArr:Array<String>) {
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
                    mealDataKey = inputArr[i+1]
                    
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
        print("test: \(g_mealMgr.todayMealData.professorPlace)")
        print("test2: \(g_mealMgr.todayMealData.studentPlace)")
        print("test3: \(g_mealMgr.todayMealData.dormitory)")
        
        
    }
}

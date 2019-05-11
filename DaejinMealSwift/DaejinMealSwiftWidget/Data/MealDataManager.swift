//
//  MealDataManager.swift
//  DaejinMealSwift
//
//  Created by hanwe on 10/03/2019.
//  Copyright © 2019 hanwe. All rights reserved.
//

import UIKit

class MealDataManager: NSObject {

    static let sharedInstance = MealDataManager()
    
    var todayMealData:MealData = MealData()
    var oneWeekData:Dictionary<String,MealData> = Dictionary()
    
    var todayYear:String = ""
    var todayMonth:String = ""
    var todayDay:String = ""
    
    private override init()
    {
    }
    
}

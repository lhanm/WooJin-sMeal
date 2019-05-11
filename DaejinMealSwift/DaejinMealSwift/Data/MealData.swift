//
//  MealData.swift
//  DaejinMealSwift
//
//  Created by hanwe on 10/03/2019.
//  Copyright © 2019 hanwe. All rights reserved.
//

import UIKit

enum meal_time_enum {
    case meal_time_morning
    case meal_time_lunch
    case meal_time_dinner
}

class MealData: NSObject {
    var professorPlace:Dictionary<meal_time_enum, Any> = Dictionary()
    var studentPlace:Dictionary<meal_time_enum, Any> = Dictionary()
    var dormitory:Dictionary<meal_time_enum, Any> = Dictionary()
}

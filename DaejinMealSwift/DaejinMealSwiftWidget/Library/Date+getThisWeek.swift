//
//  Date+getThisWeek.swift
//  DaejinMealSwift
//
//  Created by hanwe on 10/03/2019.
//  Copyright © 2019 hanwe. All rights reserved.
//

import UIKit

//extension Date {
//
//    static func today() -> Date {
//        return Date()
//    }
//
//    func next(_ weekday: Weekday, considerToday: Bool = false) -> Date {
//        return get(.Next,
//                   weekday,
//                   considerToday: considerToday)
//    }
//
//    func previous(_ weekday: Weekday, considerToday: Bool = false) -> Date {
//        return get(.Previous,
//                   weekday,
//                   considerToday: considerToday)
//    }
//
//    func get(_ direction: SearchDirection,
//             _ weekDay: Weekday,
//             considerToday consider: Bool = false) -> Date {
//
//        let dayName = weekDay.rawValue
//
//        let weekdaysName = getWeekDaysInEnglish().map { $0.lowercased() }
//
//        assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")
//
//        let searchWeekdayIndex = weekdaysName.index(of: dayName)! + 1
//
//        let calendar = Calendar(identifier: .gregorian)
//
//        if consider && calendar.component(.weekday, from: self) == searchWeekdayIndex {
//            return self
//        }
//
//        var nextDateComponent = DateComponents()
//        nextDateComponent.weekday = searchWeekdayIndex
//
//
//        let date = calendar.nextDate(after: self,
//                                     matching: nextDateComponent,
//                                     matchingPolicy: .nextTime,
//                                     direction: direction.calendarSearchDirection)
//
//        return date!
//    }
//
//}
//
//// MARK: Helper methods
//extension Date {
//    func getWeekDaysInEnglish() -> [String] {
//        var calendar = Calendar(identifier: .gregorian)
//        calendar.locale = Locale(identifier: "en_US_POSIX")
//        return calendar.weekdaySymbols
//    }
//
//    enum Weekday: String {
//        case monday, tuesday, wednesday, thursday, friday, saturday, sunday
//    }
//
//    enum SearchDirection {
//        case Next
//        case Previous
//
//        var calendarSearchDirection: Calendar.SearchDirection {
//            switch self {
//            case .Next:
//                return .forward
//            case .Previous:
//                return .backward
//            }
//        }
//    }
//}
extension Date {
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }
    
    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 7, to: sunday)
    }
    
    public func getThisWeekStrArr() ->Array<String> {
        var resultArr:Array<String> = Array()
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM/dd"
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return [""] }
        let monday:Date =  gregorian.date(byAdding: .day, value: 1, to: sunday)!
        let mondayStr:String = dateFormat.string(from: monday)
        let tuesday:Date =  gregorian.date(byAdding: .day, value: 2, to: sunday)!
        let tuesdayStr:String = dateFormat.string(from: tuesday)
        let wednesday:Date =  gregorian.date(byAdding: .day, value: 3, to: sunday)!
        let wednesdayStr:String = dateFormat.string(from: wednesday)
        let thursday:Date =  gregorian.date(byAdding: .day, value: 4, to: sunday)!
        let thursdayStr:String = dateFormat.string(from: thursday)
        let friday:Date =  gregorian.date(byAdding: .day, value: 5, to: sunday)!
        let fridayStr:String = dateFormat.string(from: friday)
        let saturday:Date =  gregorian.date(byAdding: .day, value: 6, to: sunday)!
        let saturdayStr:String = dateFormat.string(from: saturday)
        let thisSunday:Date =  gregorian.date(byAdding: .day, value: 7, to: sunday)!
        let sundayStr:String = dateFormat.string(from: thisSunday)
        resultArr.append(mondayStr)
        resultArr.append(tuesdayStr)
        resultArr.append(wednesdayStr)
        resultArr.append(thursdayStr)
        resultArr.append(fridayStr)
        resultArr.append(saturdayStr)
        resultArr.append(sundayStr)
        
        
        
        return resultArr
    }
    
}

//
//  ThisWeekData.swift
//  DaejinMealSwift
//
//  Created by hanwe on 10/03/2019.
//  Copyright © 2019 hanwe. All rights reserved.
//

import UIKit

class ThisWeekData: NSObject {

    static let sharedInstance = ThisWeekData()
    
    public var thisWeekArr:Array<String>? = nil
 
    private override init()
    {
    }
}

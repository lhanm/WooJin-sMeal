//
//  String+HTMLParsing.swift
//  DaejinMealSwift
//
//  Created by hanwe on 10/03/2019.
//  Copyright © 2019 hanwe. All rights reserved.
//

import UIKit

extension String {
    public func removeTDTag() -> String{
        var frontStartIndex:Int = 0
        var frontEndIndex:Int = 0
        var mutableStr:String = self
        
        if self.hasPrefix("<td") {
            if self.hasSuffix("</td>"){
                let range:Range = self.range(of: "</td>")!
//                str.removeRange(Range<String.Index>(start: str.startIndex, end:advance(str.startIndex, 7)))
                mutableStr.removeSubrange(range)
//                print("mutableTest \(mutableStr)")
                for i in 0 ..< mutableStr.count {
                    if (mutableStr as NSString).character(at: i) == ("<" as NSString).character(at: 0){
                        frontStartIndex = i
                    }
                    if (mutableStr as NSString).character(at: i) == (">" as NSString).character(at: 0){
                        frontEndIndex = i+1
                        let start = mutableStr.index(mutableStr.startIndex, offsetBy: frontStartIndex)
                        let end = mutableStr.index(mutableStr.startIndex, offsetBy: frontEndIndex)
                        let myRange = start..<end
                        mutableStr.removeSubrange(myRange)
//                        print("result :\(mutableStr)")
                        break
                    }
                }
            }
        }
        
        return mutableStr
    }
}

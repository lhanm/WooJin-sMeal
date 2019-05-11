//
//  WeekTableViewHeaderFooterView.swift
//  DaejinMealSwift
//
//  Created by hanwe on 17/03/2019.
//  Copyright © 2019 hanwe. All rights reserved.
//

import UIKit

class WeekTableViewHeaderFooterView: UITableViewHeaderFooterView {
    @IBOutlet var topLabel: UILabel!
    @IBOutlet var middleLabel: UILabel!
    @IBOutlet var bottomLabel: UILabel!
    @IBOutlet var topImgView: UIImageView!
    @IBOutlet var middleImgView: UIImageView!
    @IBOutlet var bottomImgView: UIImageView!
    public func fitLabel() {
        topLabel?.sizeToFit()
        middleLabel?.sizeToFit()
        bottomLabel?.sizeToFit()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

//
//  MainTableViewHeaderFooterView.swift
//  DaejinMealSwift
//
//  Created by HanWe Lee on 13/03/2019.
//  Copyright © 2019 hanwe. All rights reserved.
//

import UIKit

class MainTableViewHeaderFooterView: UITableViewHeaderFooterView {
    @IBOutlet weak var topLabel: UILabel?
    @IBOutlet weak var bottomLabel: UILabel?
    @IBOutlet weak var topImgView: UIImageView!
    @IBOutlet weak var bottomImgView: UIImageView!
    
    public func fitLabel() {
        topLabel?.sizeToFit()
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

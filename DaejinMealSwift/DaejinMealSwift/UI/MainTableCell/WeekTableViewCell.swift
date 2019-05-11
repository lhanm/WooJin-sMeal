//
//  WeekTableViewCell.swift
//  DaejinMealSwift
//
//  Created by hanwe on 17/03/2019.
//  Copyright © 2019 hanwe. All rights reserved.
//

import UIKit

class WeekTableViewCell: UITableViewCell {
    
    @IBOutlet var menuLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

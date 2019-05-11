//
//  RandomVC.swift
//  DaejinMealSwift
//
//  Created by hanwe on 17/03/2019.
//  Copyright © 2019 hanwe. All rights reserved.
//

import UIKit

class RandomVC: UIViewController {

    @IBOutlet var tmpImgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tmpImgView.image = UIImage(named: "construction")
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

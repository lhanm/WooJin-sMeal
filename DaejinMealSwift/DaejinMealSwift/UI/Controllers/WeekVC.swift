//
//  WeekVC.swift
//  DaejinMealSwift
//
//  Created by hanwe on 17/03/2019.
//  Copyright © 2019 hanwe. All rights reserved.
//

import UIKit
import GoogleMobileAds

class WeekVC: UIViewController {

    @IBOutlet var weekTableView: UITableView!
    @IBOutlet var weekTableVC: WeekTableVC!
    @IBOutlet var adView: GADBannerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.weekTableVC.registNib()
        self.weekTableVC.refreshWeekDays()
        self.weekTableView.reloadData()
        adView.adUnitID = "ca-app-pub-7046536274679093/2289866973"
        adView.rootViewController = self
        adView.load(GADRequest())
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "주간식단"
        weekTableView.reloadData()
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

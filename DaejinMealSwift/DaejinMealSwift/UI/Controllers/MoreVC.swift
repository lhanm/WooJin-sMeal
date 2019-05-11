//
//  MoreVC.swift
//  DaejinMealSwift
//
//  Created by hanwe on 19/03/2019.
//  Copyright © 2019 hanwe. All rights reserved.
//

import UIKit
import GoogleMobileAds

class MoreVC: UIViewController {

    @IBOutlet var aboutThisAppImgView: UIImageView!
    @IBOutlet var openSourceInfoImgView: UIImageView!
    @IBOutlet var configureImgView: UIImageView!
    @IBOutlet var noticeImgView: UIImageView!
    @IBOutlet var thanksToImgView: UIImageView!
    @IBOutlet var adView: GADBannerView!
    @IBOutlet var configView: TouchUIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "더보기"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func initUI() {
        self.aboutThisAppImgView.image = UIImage(named: "star")
        self.openSourceInfoImgView.image = UIImage(named: "source")
        self.configureImgView.image = UIImage(named: "config")
        self.noticeImgView.image = UIImage(named: "speaker")
        self.thanksToImgView.image = UIImage(named: "thanks")
        adView.adUnitID = "ca-app-pub-7046536274679093/4532886930"
        adView.rootViewController = self
        adView.load(GADRequest())
    }

    @IBAction func showNoticeAction(_ sender: Any) {
        if let url = URL(string: "https://blog.naver.com/PostList.nhn?blogId=lhanm&from=postList&categoryNo=18") {
            UIApplication.shared.open(url, options: [:])
        }
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

//
//  VersionVC.swift
//  DaejinMealSwift
//
//  Created by hanwe on 19/03/2019.
//  Copyright © 2019 hanwe. All rights reserved.
//

import UIKit

class VersionVC: UIViewController {

    @IBOutlet var mainImgView: UIImageView!
    @IBOutlet var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        mainImgView.image = UIImage(named: "mainImg")
        let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
        let bundleVersion = Bundle.main.infoDictionary!["CFBundleVersion"] as? String
        self.versionLabel?.text = "버전: \(String(describing: appVersion!))00\(String(describing: bundleVersion!))"
        
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

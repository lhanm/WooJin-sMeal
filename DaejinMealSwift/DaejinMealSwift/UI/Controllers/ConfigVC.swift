//
//  ConfigVC.swift
//  DaejinMealSwift
//
//  Created by hanwe on 20/03/2019.
//  Copyright © 2019 hanwe. All rights reserved.
//

import UIKit

class ConfigVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func replaceWidgetMealPlaceAction(_ sender: Any) {
        let alert = UIAlertController(title: "위젯 식당 변경", message: "위젯에서 보여지는 식당을 변경하시겠습니까?", preferredStyle: .actionSheet)
        let replaceStudentPlace:UIAlertAction = UIAlertAction(title: "학생회관으로 변경", style: .default) { (replaceStudentPlace) in
            if let userDefaults = UserDefaults(suiteName: "group.com.DaejinMealGroup") {
                userDefaults.set("student" as AnyObject, forKey: "key")
                userDefaults.synchronize()
            }
            
            let alertController = UIAlertController(title: "알림", message: "변경완료", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        let replaceDormitory:UIAlertAction = UIAlertAction(title: "생활관으로 변경", style: .default) { (replaceDormitory) in
            if let userDefaults = UserDefaults(suiteName: "group.com.DaejinMealGroup") {
                userDefaults.set("dormitory" as AnyObject, forKey: "key")
                userDefaults.synchronize()
            }
            
            let alertController = UIAlertController(title: "알림", message: "변경완료", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        let replaceProfessorPlace:UIAlertAction = UIAlertAction(title: "교수회관으로 변경", style: .default) { (replaceProfessorPlace) in
            if let userDefaults = UserDefaults(suiteName: "group.com.DaejinMealGroup") {
                userDefaults.set("professor" as AnyObject, forKey: "key")
                userDefaults.synchronize()
            }
            let alertController = UIAlertController(title: "알림", message: "변경완료", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        alert.addAction(replaceStudentPlace)
        alert.addAction(replaceDormitory)
        alert.addAction(replaceProfessorPlace)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
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

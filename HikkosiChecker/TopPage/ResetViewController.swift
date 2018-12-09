//
//  ResetViewController.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/12/09.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit
import RealmSwift
class ResetViewController: UIViewController {
let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func yesAction(_ sender: UIButton) {
        try! realm.write{
            realm.deleteAll()
        }
        progressive!.resetKey()
        progressive!.resetData()
        PlannedDate.resetKey()
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func noAction(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
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

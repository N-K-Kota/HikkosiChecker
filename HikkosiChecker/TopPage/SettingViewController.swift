//
//  SettingViewController.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/23.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit
import RealmSwift
class SettingViewController: UIViewController {
    @IBOutlet weak var dateLabel:UILabel?
    @IBOutlet weak var datePicker:UIDatePicker?
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        let vc  = self.presentingViewController as! TopPageViewController
        vc.plannedDate.date = datePicker!.date
        vc.plannedDate.setDate()
        self.dismiss(animated: true, completion: nil)
    }
    var defaultDate:Date?
    let formatter = DateFormatter()
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
            datePicker!.datePickerMode = .date
        datePicker!.setDate(defaultDate ?? Date(), animated: false)
            formatter.dateFormat = "yy-MM-dd"
            dateLabel!.text = formatter.string(from:datePicker!.date)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func datePicker(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy-MM-dd"
        dateLabel!.text = formatter.string(from: sender.date)
    }
    
    @IBAction func resetAppFunc(_ sender: UIButton) {
        /*let standard = UserDefaults.standard
        standard.removeObject(forKey: PlannedDate.key)
        standard.removeObject(forKey: "Flag")
        try! realm.write{
            realm.deleteAll()
        }*/
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

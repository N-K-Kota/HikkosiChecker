//
//  TextFieldViewController.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/29.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit
import RealmSwift
class TextFieldViewController: UIViewController,UITextFieldDelegate {
    let realm = try! Realm()
    var section:Int?
    var allAddresses:AllAddresses?
    var mykey:MyKey?
    var reload = {()->Void in}
    @IBAction func returnBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func doneBtn(_ sender: Any) {
        if(titleTextField.text != nil && titleTextField.text != ""){ //空の時は何もしない
            let task = [titleTextField.text,urlTextField.text]
            let address = Address()
            address.title = task[0]!
            if(urlTextField.text != ""){//空白を入れたくない
            address.url = urlTextField.text
            }
            try! realm.write{
                address.id = mykey!.createKey()
                allAddresses!.sections[section!].section.append(address)
            }
            
            let vc = self.presentingViewController as! CollectionViewController
            vc.addressBuffer.buffer.append(false)
            reload()
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        urlTextField.delegate = self
        titleTextField.delegate = self
        allAddresses = realm.objects(AllAddresses.self).first!
        mykey = realm.objects(MyKey.self).first!
        // Do any additional setup after loading the view.
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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

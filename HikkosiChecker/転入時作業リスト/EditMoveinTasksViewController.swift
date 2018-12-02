//
//  EditMoveinTasksViewController.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/12/01.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit
import RealmSwift
class EditMoveinTasksViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    var reload = {()->Void in}
    @IBOutlet weak var tableView: UITableView!
    @IBAction func returnFunc(_ sender: UIBarButtonItem) {
        reload()
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var textField: UITextField!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return moveinList!.taskList.count
        }else{
            return didmoveinList!.taskList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "editmoveinCell",for:indexPath) as! MyTableViewCell
        var task:Task
        if(indexPath.section == 0){
            task = moveinList!.taskList[indexPath.row]
        }else{
            task = didmoveinList!.taskList[indexPath.row]
        }
        if(task.canRemove){
            cell.setData()
            cell.label.text = task.task
            cell.btn.index = indexPath
            cell.btn.addTarget(self, action: #selector(clickFunc(_:)), for: .touchDown)
            cell.btn.setImage(UIImage(named: "deleteImg"), for: .normal)
        }else{
            cell.textLabel!.text = task.task
        }
        return cell
    }
    @objc func clickFunc(_ sender:Any){
        let btn = sender as! CustomButton
        let index = btn.index
        let cell = tableView.cellForRow(at: index)
        if(index.section == 0){
            try! realm.write {
                moveinList!.taskList.remove(at: index.row)
            }
        }else{
            try! realm.write {
                didmoveinList!.taskList.remove(at: index.row)
            }
        }
        UIView.animate(withDuration: 0.3, animations: {
            cell!.layer.opacity = 0
        }, completion:{ (bool:Bool) in
            self.tableView.reloadData()
        })
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 10))
        view.backgroundColor = .clear
        return view
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    var moveinList:MoveinList?
    var didmoveinList:DidMoveinList?
    let realm = try! Realm()
    var taskKey:TaskKey?
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        textField.returnKeyType = .done
        textField.backgroundColor = UIColor(hex: "FDC23E", alpha: 0.7)
        textField.attributedPlaceholder = NSAttributedString(string: "+ リストに追加", attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
        taskKey = realm.objects(TaskKey.self).first!
        
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //完了したらキーボードを閉じる奴
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) { //リストに追加
        if(textField.text != nil && textField.text != ""){
            let task = Task()
            task.task = textField.text!
            task.canRemove = true
            try! realm.write{
                task.id = taskKey!.createKey()
                moveinList!.taskList.append(task)
            }
            textField.text = nil
            self.tableView.reloadData()
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.resignFirstResponder()
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

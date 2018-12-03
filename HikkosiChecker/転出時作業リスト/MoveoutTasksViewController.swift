//
//  MoveoutTasksViewController.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/02.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit
import RealmSwift



class MoveoutTasksViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    /*func action(tag:Int) {
        selectedBtn = tag
      performSegue(withIdentifier: "tonext", sender: nil)
    }*/
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if(checkedObj!.watchable){                        //チェックされたリストの表示、非表示で場合わけ
            if(section < 4){
               return uncheckedObj!.sectionobjList[section].taskList.count
            }else if(section > 4){
               return checkedObj!.sectionobjList[section-5].taskList.count
            }else{
                return 1
            }
         }else{
            if(section < 4){
                return uncheckedObj!.sectionobjList[section].taskList.count
            }else if(section == 4){
                return 1
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { //セクションにリストがないときはタイトルを空に
        if(section<4){
            if(uncheckedObj!.sectionobjList[section].taskList.count > 0){
            return uncheckedObj!.sectionobjList[section].title
            }else{
                return ""
            }
        }else if(section > 4){
            if(checkedObj!.sectionobjList[section-5].taskList.count > 0){
            return checkedObj!.sectionobjList[section-5].title
            }else{
                return ""
            }
        }else{
            return ""
        }
    }
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {//アクセサリをクリックしたら詳細ページへとぶ
        if(indexPath.section < 4){
            self.selectedTask = uncheckedObj!.sectionobjList[indexPath.section].taskList[indexPath.row]
        }else if(indexPath.section > 4){
            self.selectedTask = checkedObj!.sectionobjList[indexPath.section-5].taskList[indexPath.row]
        }
        self.performSegue(withIdentifier: "totable", sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerview = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        footerview.backgroundColor = UIColor.clear
        return footerview
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moveoutcell", for: indexPath) as! MyTableViewCell
        if(indexPath.section < 4){
            cell.setData()
            cell.btn.setImage(UIImage(named: "spacerect"), for: .normal)
            cell.btn.index = indexPath
            cell.btn.addTarget(self, action: #selector(clickAction(_:)), for: .touchUpInside)
            cell.accessoryType = .detailButton
            cell.tintColor = UIColor.blue
            cell.preservesSuperviewLayoutMargins = false
            cell.separatorInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
            cell.label.text = uncheckedObj!.sectionobjList[indexPath.section].taskList[indexPath.row].task
        }else if(indexPath.section > 4){//ここにチェックされたリストの描画をかく
            cell.setData()
            cell.btn.setImage(UIImage(named: "checkFrame"), for: .normal)
            cell.btn.index = indexPath
            cell.btn.addTarget(self, action: #selector(clickCheckedbtn(_:)), for: .touchUpInside)
            cell.btn.alpha = 0.5
            cell.backgroundColor = UIColor(white: 1, alpha: 0.7)
            cell.accessoryType = .detailButton
            cell.tintColor = .blue
            cell.label.text = checkedObj!.sectionobjList[indexPath.section-5].taskList[indexPath.row].task
            cell.preservesSuperviewLayoutMargins = false
            cell.separatorInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        }else{
            if(checkedObj!.watchable){
                cell.textLabel?.text = "チェックしたリストを非表示にする"
            }else{
                cell.textLabel?.text = "チェックしたリストを表示する"
            }
            cell.layer.cornerRadius = 15
            cell.backgroundColor = UIColor(hex: "BFF4FF", alpha: 0.7)
        }
        return cell
    }
    
    @objc func clickCheckedbtn(_ sender:UIButton){       //チェックされたリストをクリックした時のアクション
        let sender = sender as! CustomButton
        let path = sender.index
        let task = checkedObj!.sectionobjList[path.section-5].taskList[path.row]
        try! realm.write{
            uncheckedObj!.sectionobjList[path.section-5].taskList.append(task)
            checkedObj!.sectionobjList[path.section-5].taskList.remove(at: path.row)
        }
        progressive!.moveoutTasksCount = uncheckedObj!.taskCount()
        progressive!.didmoveoutTasksCount = checkedObj!.taskCount()
        progressive!.save()
        tableView.reloadData()
    }
    @objc func clickAction(_ sender: UIButton) {   //リストをクリックした時のアクション
        let sender = sender as! CustomButton
        sender.isEnabled = false
        let path = sender.index
        let task = uncheckedObj!.sectionobjList[path.section].taskList[path.row]  //チェックされたTaskを取り出す
        try! realm.write{
            checkedObj!.sectionobjList[path.section].taskList.append(task)
            uncheckedObj!.sectionobjList[path.section].taskList.remove(at: path.row)  //アンチェックドリストから削除
        }
        progressive!.moveoutTasksCount = uncheckedObj!.taskCount()
        progressive!.didmoveoutTasksCount = checkedObj!.taskCount()
        progressive!.save()
        let mycell = tableView.cellForRow(at: path) as! MyTableViewCell
        let scale = UIScreen.main.scale
       UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: [.beginFromCurrentState], animations: {  //アニメーションの描画
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.1, animations: {
                sender.imageView?.center.x += (self.tableView.frame.width-sender.imageView!.frame.width)/4*scale
                sender.imageView!.transform = CGAffineTransform(rotationAngle: .pi/2)
                mycell.layer.opacity = 0.75
            })
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.1, animations: {
               
                sender.imageView?.center.x += (self.tableView.frame.width-sender.imageView!.frame.width)/4*scale
                sender.imageView!.transform = CGAffineTransform(rotationAngle: .pi/6)
                mycell.layer.opacity = 0.5
            })
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.1, animations: {
                
                sender.imageView?.center.x += (self.tableView.frame.width-sender.imageView!.frame.width)/4*scale
                mycell.layer.opacity = 0
                sender.imageView!.transform = CGAffineTransform(rotationAngle: .pi/6)
            })
        }, completion: {(bool:Bool) in
                       self.tableView.reloadData()
        })
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //チェックされたリストの表示、非表示を切り替えるセルを押された時のアクション
        if(indexPath.section == 4){
            try! realm.write{
                checkedObj!.watchable = !checkedObj!.watchable
            }
            tableView.reloadData()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if(checkedObj!.watchable){
            return (uncheckedObj!.sectionobjList.count + checkedObj!.sectionobjList.count+1)
        }else{
            return uncheckedObj!.sectionobjList.count+1
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "totable"){
            let svc = segue.destination as! NotesTableViewController
            svc.task = selectedTask
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    
    let realm = try! Realm()
    var selectedTask:Task?
    @IBAction func toTopAction(_ sender: UIBarButtonItem) {  //TopPageへ戻るボタン
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        progressive!.moveoutTasksCount = uncheckedObj!.taskCount()
        progressive!.didmoveoutTasksCount = checkedObj!.taskCount()
        progressive!.save()
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

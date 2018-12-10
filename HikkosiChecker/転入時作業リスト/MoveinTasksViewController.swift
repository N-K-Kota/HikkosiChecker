//
//  MoveinTasksViewController.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/02.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit
import RealmSwift
class MoveinTasksViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return moveinList!.taskCount()
        }
        if(section == 1){
            return 1
        }else{
            return didmoveinList!.taskCount()
        }
    }
    
    @IBAction func toTopFunc(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moveincell", for: indexPath) as! MyTableViewCell
        cell.btn.index = indexPath
        if(indexPath.section == 0){  //チェックされてない
            cell.setData()
            cell.btn.setImage(UIImage(named: "spacerect"), for: .normal)
            cell.label.text = moveinList!.taskList[indexPath.row].task
            cell.accessoryType = .detailButton
            cell.btn.addTarget(self, action: #selector(checkFunc(_:)), for: .touchDown)
        }else if(indexPath.section == 1){  //ボタン
            if(didmoveinList!.watchable){
                cell.textLabel?.text = "チェック済みリストを非表示にする"
            }else{
                cell.textLabel?.text = "チェック済みリストを表示する"
            }
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = .white
            cell.layer.cornerRadius = 20
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [UIColor(hex: "8BE9F5", alpha: 0.6).cgColor,UIColor(hex: "02AAE3",alpha:0.9).cgColor]
            gradientLayer.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: cell.frame.height)
            cell.backgroundColor = .clear
            cell.layer.insertSublayer(gradientLayer, at: 0)
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor(hex: "006577", alpha: 0.5).cgColor
        }else{    //チェックされた
            cell.setData()
            cell.btn.setImage(UIImage(named: "checkFrame"), for: .normal)
            cell.label.text = didmoveinList!.taskList[indexPath.row].task
            cell.accessoryType = .detailButton
            cell.btn.addTarget(self, action: #selector(uncheckFunc(_:)), for: .touchDown)
        }
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toMoveinNotes"){
            let vc = segue.destination as! NotesMoveinTasksViewController
            vc.task = self.task
        }else if(segue.identifier == "toMoveinEdit"){
            let vc = segue.destination as! EditMoveinTasksViewController
            vc.moveinList = moveinList
            vc.reload = {()->Void in self.tableView.reloadData()}
            vc.didmoveinList = didmoveinList
        }
    }
    @objc func checkFunc(_ sender:Any){
        let btn = sender as! CustomButton
        let task = moveinList!.taskList[btn.index.row]
        try! realm.write{
            moveinList!.taskList.remove(at: btn.index.row)
            didmoveinList!.taskList.append(task)
        }
        progressive!.moveinTasksCount = moveinList!.taskList.count
        progressive!.didmoveinTasksCount = didmoveinList!.taskList.count
        progressive!.save()
        let mycell = self.tableView.cellForRow(at: btn.index) as! MyTableViewCell
        let scale = UIScreen.main.scale
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [.beginFromCurrentState], animations: {  //アニメーションの描画
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.1, animations: {
                btn.imageView?.center.x += (self.tableView.frame.width-btn.imageView!.frame.width)/4*scale
                btn.imageView!.transform = CGAffineTransform(rotationAngle: .pi/2)
                mycell.layer.opacity = 0.75
            })
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.1, animations: {
                
                btn.imageView?.center.x += (self.tableView.frame.width-btn.imageView!.frame.width)/4*scale
                btn.imageView!.transform = CGAffineTransform(rotationAngle: .pi/6)
                mycell.layer.opacity = 0.5
            })
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.1, animations: {
                
                btn.imageView?.center.x += (self.tableView.frame.width-btn.imageView!.frame.width)/4*scale
                mycell.layer.opacity = 0.25
                btn.imageView!.transform = CGAffineTransform(rotationAngle: .pi/6)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.2, animations: {
                btn.imageView?.center.x += (self.tableView.frame.width-btn.imageView!.frame.width)/4*scale
                mycell.layer.opacity = 0
                btn.imageView!.transform = CGAffineTransform(rotationAngle: .pi/6)
            })
        }, completion: {(bool:Bool) in
            self.tableView.reloadData()
        })
    }
    @objc func uncheckFunc(_ sender:Any){
        let btn = sender as! CustomButton
        let task = didmoveinList!.taskList[btn.index.row]
        try! realm.write{
            didmoveinList!.taskList.remove(at: btn.index.row)
            moveinList!.taskList.append(task)
        }
        progressive!.moveinTasksCount = moveinList!.taskList.count
        progressive!.didmoveinTasksCount = didmoveinList!.taskList.count
        progressive!.save()
        self.tableView.reloadData()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if(didmoveinList!.watchable){
            return 3
        }else{
            return 2
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 1){
            try! realm.write{
            didmoveinList!.watchable = !didmoveinList!.watchable
            }
            tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if(indexPath.section == 0){
            self.task = moveinList!.taskList[indexPath.row]
        }else{
            self.task = didmoveinList!.taskList[indexPath.row]
        }
        performSegue(withIdentifier: "toMoveinNotes", sender: nil)
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 20))
        view.backgroundColor = .clear
        return view
    }
    @IBOutlet weak var tableView: UITableView!
    var moveinList:MoveinList?
    var didmoveinList:DidMoveinList?
    let realm = try! Realm()
    var task:Task?
    var taskKey:TaskKey?
    override func viewDidLoad() {
        super.viewDidLoad()
          taskKey = realm.objects(TaskKey.self).first!
          moveinList = realm.objects(MoveinList.self).last  //初期化
          didmoveinList = realm.objects(DidMoveinList.self).last
        if( moveinList == nil){ //オブジェクトがない場合
             moveinList = MoveinList()
             moveinList!.dataInit(taskKey:taskKey!)
             didmoveinList = DidMoveinList()
            try! realm.write{
                realm.add(moveinList!)
                realm.add(didmoveinList!)
            }
        }
        progressive!.moveinTasksCount = moveinList!.taskList.count
        progressive!.didmoveinTasksCount = didmoveinList!.taskList.count
        progressive!.save()
        let leftgesture = UISwipeGestureRecognizer()
        leftgesture.direction = .left
        leftgesture.addTarget(self, action: #selector(swipeLeft))
        let rightgesture = UISwipeGestureRecognizer()
        rightgesture.direction = .right
        rightgesture.addTarget(self,action:#selector(swipeRight))
        self.view.addGestureRecognizer(leftgesture)
        self.view.addGestureRecognizer(rightgesture)
        // Do any additional setup after loading the view.
    }
    
    @objc func swipeLeft(){
        self.tabBarController?.selectedIndex = 0
    }
    @objc func swipeRight(){
        self.tabBarController?.selectedIndex = 1
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

//
//  MoveoutTasksViewController.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/02.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit
import RealmSwift


struct DefultData{
    let task:String
    let point:String
    let requirement:String
    let memo:String
}

/*struct DefOutTasks{
    var Sectionobjs:Array<Section>
    func returnTitles()->Array<String>{
        var t = Array<String>()
        for i in sections{
            guard let ts = i.tasks else{
                return t
            }
            for v in ts{
                t.append(v.title)
            }
        }
        return t
    }
    
}
struct AllTasks{
    var sections:Array<Section>
    init(tasks:Array<Section> =  [Section(sectionTitle: "1ヶ月前まで", tasks: nil),
                                   Section(sectionTitle: "１週間前まで", tasks: nil),
                                   Section(sectionTitle: "当日まで", tasks: nil),
                                   Section(sectionTitle: "その他", tasks: nil)]){
        self.sections  = tasks
    }
}

struct UncheckedObj{
    var sections:Array<Section>
    func returnSectionTitles()->Array<String>{
        var t = Array<String>()
        for i in sections{
            t.append(i.sectionTitle)
        }
        return t
    }
    /*func returnTag(section:Int,row:Int)->Int{
        var i = 0
        var num = 0
        while(i<section){
            num += sections[i].tasks!.count
            i += 1
        }
        num += row
        return num
    }*/
    func returnTask(tag:Int)->Task?{
        for v in sections{
            for i in v.tasks!{
                if(i.tag == tag){
                    return i
                }
            }
        }
        return nil
    }
    mutating func removefromTag(tag:Int){
        var s = 0
        var r = 0
        label: for i in sections{
            r = 0
            for v in i.tasks!{
                if(v.tag == tag){
                    break label
                }
                r += 1
            }
            s += 1
        }
        print("\(s):\(r)")
        self.sections[s].tasks!.remove(at: r)
    }
}
struct Task{
    let title:String
    let point:String
    let requirement:String
    var :usermemo String?
    let tag:Int
}
struct Section{
    let sectionTitle:String
    var tasks:Array<Task>?
}

class UserOutTasks{
    var userTasks:Array<UserTask>?
    init(_ tasks:Array<UserTask>?){
        userTasks = tasks
    }
    var structTasks:Array<Task>?{
        guard userTasks != nil else{
            return nil
        }
        var t = Array<Task>()
        for i in userTasks!{
            let f = Task(title: i.title, point: i.point, requirement: i.requirement, usermemo: i.usermemo,tag:i.tag)
            t.append(f)
        }
      return t
    }
}

class UserTask{
    let title:String
    let point:String
    let requirement:String
    var usermemo:String?
    let tag:Int
    init(_ title:String = "",_ tag:Int,_ point:String = "",_ requirement:String = "",_ usermemo:String? = nil){
        self.title = title
        self.point = point
        self.requirement = requirement
        self.usermemo = usermemo
        self.tag = tag
    
  }
}
struct DoneCell{
    
}
 */
/* MyDelegate: class{
    func action(tag:Int)
    }*/

class MoveoutTasksViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    /*func action(tag:Int) {
        selectedBtn = tag
      performSegue(withIdentifier: "tonext", sender: nil)
    }*/
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if(checkedObj!.watchable){
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
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
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
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if(indexPath.section < 4){
            self.selectedTask = uncheckedObj!.sectionobjList[indexPath.section].taskList[indexPath.row]
        }else if(indexPath.section > 4){
            self.selectedTask = checkedObj!.sectionobjList[indexPath.section-5].taskList[indexPath.row]
        }
        self.performSegue(withIdentifier: "totable", sender: nil)
    }
    /*func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        /*if(section < 4){
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 20))
            headerView.backgroundColor = UIColor(white: 0.9, alpha: 0)
            headerView.tintColor = UIColor.black
            return headerView
        }else if(section > 4){
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 20))
        headerView.backgroundColor = UIColor(white: 0.6, alpha: 0.5)
        return headerView
        }else if(section == 4){
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0))
            return headerView
        }
        return nil*/
        if(section > 4){
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0))
            return headerView
        }
        return nil
    }*/
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerview = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        footerview.backgroundColor = UIColor.clear
        return footerview
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moveoutcell", for: indexPath) as! MyTableViewCell
        if(indexPath.section < 4){
            let btn = CustomButton()
            btn.setImage(UIImage(named: "spacerect"), for: .normal)
            btn.index = indexPath
            btn.frame = CGRect(x:0,y:(cell.frame.height-30)/2,width: 30,height: 30)
            btn.addTarget(self, action: #selector(clickAction(_:)), for: .touchUpInside)
            cell.accessoryType = .detailButton
            cell.tintColor = UIColor.blue
            cell.preservesSuperviewLayoutMargins = false
            cell.separatorInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
            cell.label.text = uncheckedObj!.sectionobjList[indexPath.section].taskList[indexPath.row].task
            cell.addSubview(btn)
        }else if(indexPath.section > 4){//ここにチェックされたリストの描画をかく
            let btn = CustomButton()
            btn.setImage(UIImage(named: "checkFrame"), for: .normal)
            btn.index = indexPath
            btn.frame = CGRect(x: 0, y: (cell.frame.height-30)/2, width: 30, height: 30)
            btn.addTarget(self, action: #selector(clickCheckedbtn(_:)), for: .touchUpInside)
            btn.alpha = 0.5
            cell.backgroundColor = UIColor(white: 1, alpha: 0.7)
            cell.accessoryType = .detailButton
            cell.tintColor = .blue
            cell.label.text = checkedObj!.sectionobjList[indexPath.section-5].taskList[indexPath.row].task
            cell.preservesSuperviewLayoutMargins = false
            cell.separatorInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
            cell.addSubview(btn)
        }else{
            if(checkedObj!.watchable){
                cell.textLabel?.text = "チェックしたリストを非表示にする"
            }else{
                cell.textLabel?.text = "チェックしたリストを表示する"
            }
            cell.accessoryType = .none
            cell.layer.cornerRadius = 15
        }
        return cell
    }
    
    @objc func clickCheckedbtn(_ sender:UIButton){
        let sender = sender as! CustomButton
        let path = sender.index
        let task = checkedObj!.sectionobjList[path.section-5].taskList[path.row]
        try! realm.write{
            uncheckedObj!.sectionobjList[path.section-5].taskList.append(task)
            checkedObj!.sectionobjList[path.section-5].taskList.remove(at: path.row)
        }
        progressive!.ratio = RatioDatasource.returnRatio(uncheckedTaskCount:uncheckedObj!.taskCount(),checkedTaskCount:checkedObj!.taskCount())
        print(progressive!.ratio)
        progressive!.save()
        tableView.reloadData()
    }
    @objc func clickAction(_ sender: UIButton) {
        let sender = sender as! CustomButton
        let path = sender.index
        let task = uncheckedObj!.sectionobjList[path.section].taskList[path.row]  //チェックされたTaskを取り出す
        try! realm.write{
            checkedObj!.sectionobjList[path.section].taskList.append(task)
             uncheckedObj!.sectionobjList[path.section].taskList.remove(at: path.row)  //アンチェックドリストから削除
        }
        progressive!.ratio = RatioDatasource.returnRatio(uncheckedTaskCount: uncheckedObj!.taskCount(),checkedTaskCount: checkedObj!.taskCount())
        print(uncheckedObj!.taskCount())
        print(checkedObj!.taskCount())
        print(progressive!.ratio)
        progressive!.save()
        let mycell = tableView.cellForRow(at: path) as! MyTableViewCell
        let scale = UIScreen.main.scale
        let defview =  mycell.backgroundView
       UIView.animateKeyframes(withDuration: 0.4, delay: 0, options: [.beginFromCurrentState], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.1, animations: {
                sender.setImage(UIImage(named:"orangeCar"), for: .normal)
                sender.imageView!.center.x += (self.tableView.frame.width-sender.imageView!.frame.width)/4*scale
                    mycell.backgroundView = UIView(frame: CGRect(x: 0, y:sender.imageView!.center.y , width:sender.imageView!.center.x , height: 10))
                mycell.backgroundView?.backgroundColor = UIColor.brown
            })
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.1, animations: {
               sender.imageView!.center.x += (self.tableView.frame.width-sender.imageView!.frame.width)/4*scale
                mycell.backgroundView = UIView(frame: CGRect(x: 0, y:sender.imageView!.center.y , width:sender.imageView!.center.x , height: 10))
                mycell.backgroundView?.backgroundColor = UIColor.brown
            })
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.1, animations: {
                sender.imageView!.center.x += (self.tableView.frame.width-sender.imageView!.frame.width)/4*scale
                mycell.backgroundView = UIView(frame: CGRect(x: 0, y:sender.imageView!.center.y , width:sender.imageView!.center.x , height: 10))
                mycell.backgroundView?.backgroundColor = UIColor.brown
                
            })
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.1, animations: {
                sender.imageView!.center.x += (self.tableView.frame.width-sender.imageView!.frame.width)/4*scale
               
                mycell.backgroundView = UIView(frame: CGRect(x: 0, y:sender.imageView!.center.y , width:sender.imageView!.center.x , height: 10))
                mycell.backgroundView?.backgroundColor = UIColor.yellow
            })
        }, completion: {(bool:Bool) in
                       sender.setImage(UIImage(named: "spacerect"), for: .normal)
                       self.tableView.reloadData()
                       mycell.backgroundView =  defview
        })
    }
    /*func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return allTasks!.returnSectionTitles()
    }*/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
        if(segue.identifier == "tonext"){
            let svc = segue.destination as! MoveOutNotesViewController
            svc.task = selectedTask
        }else if(segue.identifier == "totable"){
            let svc = segue.destination as! NotesTableViewController
            svc.task = selectedTask
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    
    let realm = try! Realm()
    var selectedTask:Task?
    @IBAction func toTopAction(_ sender: UIBarButtonItem) {
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
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

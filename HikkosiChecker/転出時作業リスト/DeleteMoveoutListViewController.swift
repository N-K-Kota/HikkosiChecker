//
//  DeleteMoveoutListViewController.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/13.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

/*import UIKit
import RealmSwift
class DeleteMoveoutListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deletableList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deletablecell", for: indexPath) as! MyTableViewCell
        cell.label.text = deletableList[indexPath.row].task.task
        let btn = CustomButton()
        btn.index = indexPath
        btn.setImage(UIImage(named:"spacerect"), for: .normal)
        btn.addTarget(self, action: #selector(checkAction(_:)), for: .touchUpInside)
        btn.frame = CGRect(x: 10, y: (cell.frame.height-btn.width)/2, width: btn.width, height: btn.height)
        cell.addSubview(btn)
        return cell
    }
    
    @objc func checkAction(_ sender:Any){
        let sender = sender as! CustomButton
        if(sender.checkedFlag){
            sender.setImage(UIImage(named: "spacerect"), for: .normal)
            sender.checkedFlag = false
            let ind = checkedList.index(of:deletableList[sender.index.row].task)
            checkedList.remove(at:ind!)
        }else{
            sender.setImage(UIImage(named: "checkFrame"), for: .normal)
            sender.checkedFlag = true
            checkedList.append(deletableList[sender.index.row].task)
        }
    }
    @IBOutlet weak var tableView: UITableView!
    @IBAction func returnBtn(_ sender: UIBarButtonItem) {
        reloadFunc()
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func deleteBtn(_ sender: UIButton) {
        for v in checkedList{
            var n = 0
            for i in deletableList{
                if(i.task == v){
                    if(i.flag){
                      try! realm.write{
                        uncheckedObj!.sectionobjList[i.index.section].taskList.remove(at: i.index.row)
                      }
                    }else{
                        try! realm.write{
                            checkedObj!.sectionobjList[i.index.section].taskList.remove(at:i.index.row)
                        }
                    }
                    deletableList.remove(at: n)
                    break
                }
                n += 1
            }
      }
        
        checkedList = Array<String>()
        tableView.reloadData()
    }
    var reloadFunc = {()->Void in}
    var checkedList = Array<String>()
    var deletableList = Array<DeletableList>()
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        var s = 0
        var r = 0
        for i in uncheckedObj!.sectionobjList{
            for v in i.taskList{
                if(v.canRemove){
                    deletableList.append(DeletableList(v.task,IndexPath(row: r, section: s),true))
                }
                r += 1
            }
            r = 0
            s += 1
        }
        s = 0
        r = 0
        for i in checkedObj!.sectionobjList{
            for v in i.taskList{
                if(v.canRemove){
                    deletableList.append(DeletableList(v.task,IndexPath(row: r, section: s),false))
                }
                r += 1
            }
            r = 0
            s += 1
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}*/

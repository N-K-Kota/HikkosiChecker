//
//  ViewController.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/02.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit
import RealmSwift
class AddressesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIViewControllerTransitioningDelegate{
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if(section < 4){
            return myList.sections[section].section.count+1
         }else if(section == 4){
            return 1
         }else{
            return checkedList.sections[section-5].section.count+1
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30)
        view.backgroundColor = .clear
        return view
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0){
            if(indexPath.section == 4){
                return 30
            }else{
            return 25
            }
        }else{
            return 50
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 4){
            if(checkedList.watchable){
            try! realm.write{
                checkedList.watchable = false
            }
          }else{
            try! realm.write{
                checkedList.watchable = true
            }
         }
          self.tableView.reloadData()
        }
        }
    var u:String?
    var webT:String?
    var selectedID:Int?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if(segue.identifier == "toCollection"){
            let vc = segue.destination as! CollectionViewController
            vc.sectionID = selectedID!
            vc.mylist = myList
            vc.dataList = allAddresses!.sections[selectedID!].section
       }else if(segue.identifier == "toWeb"){
            let vc = segue.destination as! WebPageViewController
            vc.url = self.u
            vc.pageTitle = webT
       }else if(segue.identifier == "toDelAddress"){
            let vc = segue.destination as! DeleteAddressViewController
            vc.checkedList = checkedList
            vc.myList = myList
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "addresscell", for: indexPath) as! MyTableViewCell
        
                if(indexPath.section < 4){    //チェックしてないリスト
                if(indexPath.row == 0){       //セクションヘッダーの代わり(追加ボタンがつく)
                    cell.textLabel?.text = myList.sections[indexPath.section].title
                    let acView = CustomButton()
                    acView.setImage(UIImage(named: "plus"), for: .normal)
                    acView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
                    acView.index = indexPath
                    acView.addTarget(self, action: #selector(plusTap(_:)), for: .touchUpInside)
                    cell.accessoryView = acView
                    cell.backgroundColor = UIColor(white: 0.9, alpha: 1)
                }else{
                    cell.btn.primaryKey = myList.sections[indexPath.section].section[indexPath.row-1].id
                    cell.setData()
                    cell.btn.index = indexPath
                    cell.accessoryView = nil
                    cell.accessoryType = .detailDisclosureButton
                    cell.btn.setImage(UIImage(named: "spacerect"), for: .normal)
                    cell.btn.addTarget(self, action: #selector(clickBtn(_:)), for: .touchUpInside)
                    cell.label.text = myList.sections[indexPath.section].section[indexPath.row-1].title
                }
            }else if(indexPath.section > 4){   //チェックしたリスト
                    if(indexPath.row == 0){    //セクションヘッダーの代わり(チェックしたリストにはボタンがつかない)
                        cell.textLabel?.text = checkedList.sections[indexPath.section-5].title
                        cell.accessoryView = nil
                        cell.backgroundColor = UIColor(white: 0.9, alpha: 1)
                    }else{
                        cell.setData()
                        cell.btn.index = indexPath
                        cell.accessoryView = nil
                        cell.btn.primaryKey = checkedList.sections[indexPath.section-5].section[indexPath.row-1].id
                        cell.accessoryType = .detailDisclosureButton
                        cell.btn.setImage(UIImage(named: "checkFrame"), for: .normal)
                        cell.btn.addTarget(self, action: #selector(clickCheckedBtn(_:)), for: .touchUpInside)
                        cell.label.text = checkedList.sections[indexPath.section-5].section[indexPath.row-1].title
                    }
            }else{
                    cell.accessoryView = nil
                    cell.layer.cornerRadius = 10
                    cell.accessoryType = .none
                    if(checkedList.watchable){
                       cell.backgroundColor = UIColor(hex: "00bfff", alpha: 0.7)
                       cell.textLabel!.text = "チェックされたリストを非表示にする"
                    }else{
                       cell.backgroundColor = UIColor(hex: "00bfff", alpha: 1)
                       cell.textLabel!.text = "チェックされたリストを表示する"
                   }
            }
        return cell
    }
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return JumpPresentation(presentedViewController:presented,presenting:presenting)
    }
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if(indexPath.section < 4){
            if(indexPath.row > 0){  //セルをクリックしたらアサーションを表示する  unchecked
                if let ur = myList.sections[indexPath.section].section[indexPath.row-1].url{ //urlがnilの時はURL入力ページを表示する
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "assertionView") as! assertionView
                    self.u = ur
                    self.webT = myList.sections[indexPath.section].section[indexPath.row-1].title
                    vc.jump = {()-> () in self.performSegue(withIdentifier: "toWeb", sender: nil)}
                    vc.url = ur
                    vc.transitioningDelegate = self
                    vc.modalPresentationStyle = .custom
                    self.present(vc, animated: false, completion: nil)
                }else{
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "setURLView") as! SetURLViewController
                    vc.modalPresentationStyle = .custom //presentainControllerの設定
                    vc.transitioningDelegate = self
                    vc.addressData = myList.sections[indexPath.section].section[indexPath.row-1]
                    present(vc, animated: true, completion: nil)
                }
            }
        }else{
            if(indexPath.row > 0){ //セルをクリックしたらURLのページへとぶ  checked
                if let ur = checkedList.sections[indexPath.section-5].section[indexPath.row-1].url{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "assertionView") as! assertionView
                    self.u = ur
                    self.webT = checkedList.sections[indexPath.section].section[indexPath.row-1].title
                    vc.url = ur
                    vc.jump = {()-> () in self.performSegue(withIdentifier: "toWeb", sender: nil)}
                    vc.transitioningDelegate = self
                    vc.modalPresentationStyle = .custom
                    self.present(vc, animated: false, completion: nil)
                }else{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "setURLView") as! SetURLViewController
                    vc.modalPresentationStyle = .custom //presentainControllerの設定
                    vc.transitioningDelegate = self
                    vc.addressData = checkedList.sections[indexPath.section-5].section[indexPath.row-1]
                    present(vc, animated: true, completion: nil)
                }
            }
        }
    }
    @objc func clickBtn(_ sender:Any){
        let sender = sender as! CustomButton
        let id = sender.primaryKey
        let s = sender.index.section
        var n = 0
        var task = Address()
        for i in myList.sections[s].section{//押されたセルのタスクを取得
            if(i.id == id){
                try! realm.write{
                    i.checked = true
                }
                task = i
                break
            }
            n += 1
        }
             myList.sections[s].section.remove(at: n)
             checkedList.sections[s].section.append(task)
            let cell = self.tableView.cellForRow(at: sender.index)
            UIView.animate(withDuration: 0.2, animations: {
                cell?.layer.opacity = 0
            }, completion: {(bool:Bool)-> Void in
                self.tableView.reloadData()})
    }
    @objc func clickCheckedBtn(_ sender:Any){
        let sender = sender as! CustomButton
        let s = sender.index.section-5
        let id = sender.primaryKey
        var n = 0
        var task = Address()
        for i in checkedList.sections[s].section{
            if(id == i.id){
                try! realm.write{
                    i.checked = false
                }
                task = i
                break
            }
            n += 1
        }
        checkedList.sections[s].section.remove(at: n)
        myList.sections[s].section.append(task)
        self.tableView.reloadData()
    }
    @IBAction func toTopFunc(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func plusTap(_ sender:Any){
        let sender = sender as! CustomButton
        selectedID = sender.index.section
        performSegue(withIdentifier: "toCollection", sender: nil)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if(checkedList.watchable == false){
            return myList.sections.count + 1
        }else{
            return myList.sections.count + checkedList.sections.count + 1
        }
    }
    @IBAction func deleteBtn(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier:"toDelAddress" , sender: nil)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if(indexPath.row != 0){
            return true
        }else{
            return false
        }
    }
    
    @IBOutlet weak var deleteBtn: UIBarButtonItem!
    var realm = try! Realm()
    var myList = AddressView()
    var checkedList = AddressView()
    var allAddresses:AllAddresses?
    var mykey:MyKey?    //primaryKeyを計算するクラス
    override func viewDidLoad() {
        super.viewDidLoad()
        allAddresses = realm.objects(AllAddresses.self).first
        mykey = realm.objects(MyKey.self).first
        if(allAddresses == nil){
            mykey = MyKey()
            allAddresses = AllAddresses()
            allAddresses!.initData(mykey!)
            try! realm.write{
                realm.add(mykey!)
                realm.add(allAddresses!)
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        myList.initData()
        checkedList.initData()
        allAddresses!.diplayDatas(myList: myList, checkedList: checkedList)
        progressive!.didAddressCount = checkedList.taskCount() //作業達成度を記録する
        progressive!.allAddressCount =  myList.taskCount()+checkedList.taskCount()
        progressive!.save()
        tableView.reloadData()
    }
}


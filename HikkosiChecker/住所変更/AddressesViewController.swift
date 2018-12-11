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
                return 40
            }else{
            return 28
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
        }else if(indexPath.section < 4){
            if(indexPath.row == 0){
                selectedID = indexPath.section
                performSegue(withIdentifier: "toCollection", sender: nil)
            }
        }
        }
    var selectedID:Int?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if(segue.identifier == "toCollection"){
            let vc = segue.destination as! CollectionViewController
            vc.sectionID = selectedID!
            vc.mylist = myList
            vc.dataList = allAddresses!.sections[selectedID!].section
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
                    cell.backgroundColor = UIColor(hex: "E9E9E9")
                    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
                    cell.textLabel?.textColor = UIColor(white: 0.2, alpha: 1)
                }else{
                    cell.btn.primaryKey = myList.sections[indexPath.section].section[indexPath.row-1].id
                    cell.setData()
                    cell.btn.index = indexPath
                    cell.accessoryView = nil
                    cell.accessoryType = .detailDisclosureButton
                    cell.btn.setImage(UIImage(named: "spacerect"), for: .normal)
                    cell.btn.addTarget(self, action: #selector(clickBtn(_:)), for: .touchUpInside)
                    cell.label.text = myList.sections[indexPath.section].section[indexPath.row-1].title
                    cell.label.textColor = UIColor(white: 0.2, alpha: 1)
                }
            }else if(indexPath.section > 4){   //チェックしたリスト
                    if(indexPath.row == 0){    //セクションヘッダーの代わり(チェックしたリストにはボタンがつかない)
                        cell.textLabel?.text = checkedList.sections[indexPath.section-5].title
                        cell.accessoryView = nil
                        cell.backgroundColor = UIColor(hex: "E9E9E9",alpha:0.6)
                        cell.textLabel?.alpha = 0.6
                        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
                        cell.textLabel?.textColor = UIColor(white: 0.2, alpha: 1)
                    }else{
                        cell.setData()
                        cell.btn.index = indexPath
                        cell.accessoryView = nil
                        cell.btn.primaryKey = checkedList.sections[indexPath.section-5].section[indexPath.row-1].id
                        cell.accessoryType = .detailDisclosureButton
                        cell.btn.setImage(UIImage(named: "checkFrame"), for: .normal)
                        cell.btn.addTarget(self, action: #selector(clickCheckedBtn(_:)), for: .touchUpInside)
                        cell.label.text = checkedList.sections[indexPath.section-5].section[indexPath.row-1].title
                        cell.label.textColor = UIColor(white: 0.2, alpha: 1)
                        cell.backgroundColor = UIColor(white: 1, alpha: 0.6)
                        cell.btn.layer.opacity = 0.6
                        cell.label.layer.opacity = 0.6
                        cell.label.backgroundColor = UIColor(white: 1, alpha: 0)
                    }
            }else{
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
                    if(checkedList.watchable){
                       cell.textLabel!.text = "チェック済みリストを非表示にする"
                    }else{
                       cell.textLabel!.text = "チェック済みリストを表示する"
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
                    vc.url = ur
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
    @objc func clickBtn(_ sender:Any){          //空のチェックボックスをクリックした時
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
           progressive!.didAddressCount = checkedList.taskCount() //作業達成度を記録する
           progressive!.save()
            UIView.animate(withDuration: 0.2, animations: {
                cell?.layer.opacity = 0
            }, completion: {(bool:Bool)-> Void in
                self.tableView.reloadData()})
    }
    @objc func clickCheckedBtn(_ sender:Any){      //チェック済みのボックスをクリックした時
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
        progressive!.didAddressCount = checkedList.taskCount() //作業達成度を記録する
        progressive!.save()
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
    @IBAction func deleteBtn(_ sender: UIBarButtonItem) {    //削除モードへ
        self.performSegue(withIdentifier:"toDelAddress" , sender: nil)
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
        let leftGesture = UISwipeGestureRecognizer()
        leftGesture.direction = .left
        leftGesture.addTarget(self, action: #selector(swipeLeft))
        self.view.addGestureRecognizer(leftGesture)
        let rightGesture = UISwipeGestureRecognizer()
        rightGesture.direction = .right
        rightGesture.addTarget(self, action: #selector(swipeRight))
        self.view.addGestureRecognizer(rightGesture)
        // Do any additional setup after loading the view, typically from a nib.
    }
    @objc func swipeLeft(){
        self.tabBarController?.selectedIndex = 2
    }
    @objc func swipeRight(){
        self.tabBarController?.selectedIndex = 0
    }
    override func viewWillAppear(_ animated: Bool) {
        myList.initData()           //表示用データの初期化
        checkedList.initData()
        allAddresses!.diplayDatas(myList: myList, checkedList: checkedList) //表示用データに入力
        progressive!.didAddressCount = checkedList.taskCount()             //作業達成度を記録する
        progressive!.allAddressCount =  myList.taskCount()+checkedList.taskCount()
        progressive!.save()
        tableView.reloadData()
    }
}


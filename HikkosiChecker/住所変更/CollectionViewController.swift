//
//  CollectionViewController.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/27.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit
import RealmSwift
class CollectionViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate {
    let identifier = "addresscollectionCell"
    var mylist:MyAddresses?
    @IBOutlet weak var collectionView: UICollectionView!
    var sectionID = 0
    var listBuf = Array<Int>()
    var dataList = List<Address>() //表示するリスト
    let realm = try! Realm()
    var reload = {()->Void in}
    @IBAction func returnBtn(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return  dataList.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CustomCollectionViewCell
        if(dataList[indexPath.row].flag){
            if(listBuf.index(of:indexPath.row) != nil){
                cell.btn.setImage(UIImage(named: "checkFrame"), for: .normal)
                cell.btn.addTarget(self, action: #selector(clickcheckedCell(_:)), for: .touchUpInside)
            }else{
                cell.btn.setImage(UIImage(named: "spacerect"), for: .normal)
                cell.btn.addTarget(self, action: #selector(clickCellFunc(_:)), for: .touchUpInside)
            }
            cell.label.text = dataList[indexPath.row].title
            cell.btn.index = indexPath
        }
        return cell
    }
    @objc func clickCellFunc(_ sender:Any){
           let sender = sender as! CustomButton
           listBuf.append(sender.index.row)
           self.collectionView.reloadItems(at: [sender.index])
    }
    @objc func clickcheckedCell(_ sender:Any){
        let send = sender as! CustomButton
        let id = listBuf.index(of:send.index.row)
        listBuf.remove(at: id!)
        self.collectionView.reloadItems(at: [send.index])
    }
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        for i in listBuf{
            try! realm.write{
                dataList[i].flag = false
                mylist!.sections[sectionID].section.append(dataList[i])
            }
        }
        self.dismiss(animated: true, completion: nil)
        reload()
    }
   let textField = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
    self.collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
          dataList = allAddresses.resList(sectionID)!
           let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: self.view.frame.width/2-10, height: 50)
          collectionView.collectionViewLayout = flowLayout
        textField.delegate = self
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .done
        textField.borderStyle = .roundedRect
        self.view.addSubview(textField)
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let naviHeight = 44 + self.view.safeAreaInsets.bottom
        textField.frame = CGRect(x: (self.view.frame.width-200)/2, y: naviHeight+10, width: 200, height: 60)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(self.textField.isFirstResponder){
            self.textField.resignFirstResponder()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        let address = Address()
        if(textField.text != nil && textField.text != ""){
            address.title = textField.text!
            address.flag = true
            address.url = ""
            listBuf.append(dataList.count)
        try! realm.write{
            dataList.append(address)
        }
            self.collectionView.reloadData()
        }
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

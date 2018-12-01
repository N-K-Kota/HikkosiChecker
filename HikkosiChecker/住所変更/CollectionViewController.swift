//
//  CollectionViewController.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/27.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit
import RealmSwift
class CollectionViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UIViewControllerTransitioningDelegate {
    let identifier = "addresscollectionCell"
    var mylist:MyAddresses?
    @IBOutlet weak var collectionView: UICollectionView!
    var sectionID = 0
    var listBuf = Array<Bool>()
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
            if(listBuf[indexPath.row]){
                cell.btn.setImage(UIImage(named: "checkFrame"), for: .normal)
                cell.btn.addTarget(self, action: #selector(clickcheckedCell(_:)), for: .touchUpInside)
            }else{
                cell.btn.setImage(UIImage(named: "spacerect"), for: .normal)
                cell.btn.addTarget(self, action: #selector(clickCellFunc(_:)), for: .touchUpInside)
            }
            cell.label.text = dataList[indexPath.row].title
            cell.btn.index = indexPath
        }else{
            
        }
        return cell
    }
    @objc func clickCellFunc(_ sender:Any){
           let sender = sender as! CustomButton
           listBuf[sender.index.row]=true
           self.collectionView.reloadItems(at: [sender.index])
    }
    @objc func clickcheckedCell(_ sender:Any){
        let send = sender as! CustomButton
        listBuf[send.index.row]=false
        self.collectionView.reloadItems(at: [send.index])
    }
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        var n = 0
        for i in listBuf{
            if(i){
            try! realm.write{
                dataList[n].flag = false
                mylist!.sections[sectionID].section.append(dataList[n])
            }
            }
            n += 1
        }
        self.dismiss(animated: true, completion: nil)
        reload()
    }
    @IBAction func deleteBtn(_ sender: UIBarButtonItem) {
        var n = 0
        for i in listBuf{
            if(i){
                try! realm.write{
                    dataList.remove(at: n)
                }
                n -= 1
            }
            n += 1
        }
        listBuf = Array<Bool>()
        for _ in 0..<dataList.count{
            listBuf.append(false)
        }
        print(dataList)
        self.collectionView.reloadData()
    }
    @IBAction func createNewListBtn(_ sender: UIBarButtonItem) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "textFieldView") as! TextFieldViewController
        vc.reload = {()->Void in self.collectionView.reloadData()}
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .custom
        vc.section = sectionID
        present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    self.collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
          dataList = allAddresses.resList(sectionID)!
           let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: self.view.frame.width/2-10, height: 50)
          collectionView.collectionViewLayout = flowLayout
        for _ in 0..<dataList.count{
            listBuf.append(false)
        }
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return CustomPresentationViewController(presentedViewController:presented,presenting:presenting)
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

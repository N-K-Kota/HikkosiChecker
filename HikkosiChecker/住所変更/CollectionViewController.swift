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
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    let identifier = "addresscollectionCell"
    var dataList:List<Address>?
    var mylist:MyAddresses?
    @IBOutlet weak var collectionView: UICollectionView!
    var sectionID = 0
    let realm = try! Realm()
    var reload = {()->Void in}
    @IBAction func returnBtn(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return  dataList!.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CustomCollectionViewCell
        if(dataList![indexPath.row].flag){
            if(addressBuffer.buffer[indexPath.row]){
                cell.btn.setImage(UIImage(named: "checkFrame"), for: .normal)
                cell.btn.addTarget(self, action: #selector(clickcheckedCell(_:)), for: .touchUpInside)
            }else{
                cell.btn.setImage(UIImage(named: "spacerect"), for: .normal)
                cell.btn.addTarget(self, action: #selector(clickCellFunc(_:)), for: .touchUpInside)
            }
            cell.label.text = dataList![indexPath.row].title
            cell.btn.index = indexPath
        }
        return cell
    }
    @objc func clickCellFunc(_ sender:Any){
           let btn = sender as! CustomButton
           addressBuffer.addbuf(btn.index.row)
           self.collectionView.reloadItems(at: [btn.index])
           addBtn.layer.opacity = 1
           deleteBtn.layer.opacity = 1
    }
    @objc func clickcheckedCell(_ sender:Any){
        let btn = sender as! CustomButton
        addressBuffer.subbuf(btn.index.row)
        self.collectionView.reloadItems(at: [btn.index])
        if(!addressBuffer.checkStart){
            addBtn.layer.opacity = 0
            deleteBtn.layer.opacity = 0
        }
    }
   
    @IBAction func createNewListBtn(_ sender: UIBarButtonItem) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "textFieldView") as! TextFieldViewController
        vc.reload = {()->Void in self.collectionView.reloadData()}
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .flipHorizontal
        vc.section = sectionID
        present(vc, animated: true, completion: nil)
    }
    var addressBuffer = AddressBufer()
    override func viewDidLoad() {
        super.viewDidLoad()
    self.collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        dataList = allAddresses.resList(sectionID)!
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: self.view.frame.width/2-10, height: 50)
          collectionView.collectionViewLayout = flowLayout
        var listBuf = Array<Bool>()
        for _ in 0..<dataList!.count{
            listBuf.append(false)
        }
        addBtn.layer.opacity = 0
        deleteBtn.layer.opacity = 0
        addressBuffer.buffer = listBuf
        
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    @IBAction func addFunc(_ sender: UIButton) {
        var n = 0
        for i in addressBuffer.buffer{
            if(i){
                try! realm.write{
                    dataList![n].flag = false
                    mylist!.sections[sectionID].section.append(dataList![n])
                }
            }
            n += 1
        }
        self.dismiss(animated: true, completion: nil)
        reload()
    }
    
    @IBAction func deleteFunc(_ sender: UIButton) {
        var n = 0
        for i in addressBuffer.buffer{
            if(i){
                try! realm.write{
                    dataList!.remove(at: n)
                }
                n -= 1
            }
            n += 1
        }
        print("deleted")
        addressBuffer.setBuffer(dataList!.count)
        self.collectionView.reloadData()
    }
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return TopPresentationController(presentedViewController:presented,presenting:presenting)
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

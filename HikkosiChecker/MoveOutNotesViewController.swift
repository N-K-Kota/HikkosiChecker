//
//  MoveOutNotesViewController.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/02.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit

class MoveOutNotesViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    var task:Task?
    lazy var pointView = PointView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: pointView.frame.height)
        scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height:pointView.frame.height )
        pointView.ptext = task!.point
        scrollView.addSubview(pointView)
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("noteLayout")
        pointView.backgroundColor = .blue
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: pointView.frame.height)
    }
    override func viewWillAppear(_ animated: Bool) {
       // taskLabel.text = task!.title
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

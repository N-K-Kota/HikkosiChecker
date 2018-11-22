//
//  TopPageViewController.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/21.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit
var checkedObj:CheckedObj?
var uncheckedObj:UncheckedObj?
var progressive:Progressive?
class TopPageViewController: UIViewController {
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var plannedDateLabel: UILabel!
    @IBOutlet weak var leftDateLabel: UILabel!
    @IBOutlet weak var perProgressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progImageView: UIImageView!
    var progressVal:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
            progressive = Progressive(0.0)
            progressive!.read()
            progressView.setProgress(progressive!.ratio, animated: false)
            perProgressLabel.text = "\(progressView.progress*100)%"
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let x = progressive!.ratio * Float(progressView.frame.width)
        let transform = CGAffineTransform(translationX: CGFloat(x)-progImageView.frame.width/2, y: 0)
        progImageView.transform = transform
    }
    override func viewWillAppear(_ animated: Bool) {
        print("appear")
        progressView.setProgress(progressive!.ratio, animated: true)
        perProgressLabel.text = "\(progressView.progress*100)%"
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

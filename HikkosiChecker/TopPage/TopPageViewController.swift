//
//  TopPageViewController.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/21.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit

var progressive:Progressive?
class TopPageViewController: UIViewController {
    @IBOutlet weak var wrapStackView: UIStackView!
    @IBOutlet weak var plannedStack: UIStackView!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var plannedDateLabel: UILabel!
    @IBOutlet weak var leftDateLabel: UILabel!
    @IBOutlet weak var perProgressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progImageView: UIImageView!
    @IBOutlet weak var settingStack: UIStackView!
    @IBOutlet weak var progressStack: UIStackView!
    var progressVal:Int?
    var plannedDate = PlannedDate()
    override func viewDidLoad() {
        super.viewDidLoad()
            progressive = Progressive(0.0)
            perProgressLabel.text = "\(progressView.progress*100)%"
            plannedDate.readDate()
            plannedStack.translatesAutoresizingMaskIntoConstraints = false
            leftDatesStack.translatesAutoresizingMaskIntoConstraints = false
            progressStack.translatesAutoresizingMaskIntoConstraints = false
            settingStack.translatesAutoresizingMaskIntoConstraints = false
        wrapStackView.translatesAutoresizingMaskIntoConstraints = false
            listButton.backgroundColor = UIColor(hex: "FFC817", alpha: 1)
            listButton.layer.cornerRadius = 40
            listButton.tintColor = .white
            listButton.layer.borderColor = UIColor(hex: "C4990C", alpha: 1).cgColor
            listButton.layer.borderWidth = 2.0
            settingButton.layer.cornerRadius = 5
            settingButton.backgroundColor = UIColor(hex: "40AEF9", alpha: 1)
            settingButton.layer.borderColor = UIColor(hex: "207DBD", alpha: 1).cgColor
            settingButton.layer.borderWidth = 2.0
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var leftDatesStack: UIStackView!
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let guide = self.view.layoutMarginsGuide
        let safe = self.view.safeAreaInsets
        let x = progressive!.ratio * Float(progressView.frame.width)
        let transform = CGAffineTransform(translationX: CGFloat(x)-progImageView.frame.width/2, y: 0)
        progImageView.transform = transform
        if(self.traitCollection.userInterfaceIdiom == .pad){
            wrapStackView.topAnchor.constraint(equalTo:guide.topAnchor , constant: 100).isActive = true
            wrapStackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 80).isActive=true
            wrapStackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -80).isActive=true
            wrapStackView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -100).isActive = true
        }else{
            wrapStackView.topAnchor.constraint(equalTo:guide.topAnchor , constant: 20+safe.top).isActive = true
            wrapStackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20+safe.left).isActive=true
            wrapStackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20-safe.right).isActive=true
            wrapStackView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -20-safe.bottom).isActive = true
        }
        settingStack.widthAnchor.constraint(equalToConstant: 80).isActive = true
        settingStack.heightAnchor.constraint(equalToConstant: 150).isActive = true
        listButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        listButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
        
    override func viewWillAppear(_ animated: Bool) {
        plannedDateLabel.text = plannedDate.toString()
        leftDateLabel.text = plannedDate.leftDates()
        progressive!.read()
        progressive!.setRatio()
        progressView.setProgress(progressive!.ratio, animated: true)
        perProgressLabel.text = "\(progressView.progress*100)%"
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "tosetting"){
            let vc = segue.destination as! SettingViewController
            vc.modalTransitionStyle = .crossDissolve
            vc.defaultDate = plannedDate.date
        }
    }

}

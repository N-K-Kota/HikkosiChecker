//
//  WebPageViewController.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/30.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit
import WebKit
class WebPageViewController: UIViewController,WKNavigationDelegate,WKUIDelegate{
    var url : String?
    var pageTitle: String?
    var label = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
         webView.navigationDelegate = self
         webView.uiDelegate = self
        if let u = URL(string: url!){
            self.navigationItem.title = pageTitle
            let request = URLRequest(url: u)
            webView.load(request)
        }else{
            label.text = "URLが無効です"
            label.textColor = UIColor(white: 0.5, alpha: 1)
            label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight(rawValue: 8))
            label.frame = CGRect(x: (self.view.frame.width-160)/2, y: self.view.frame.height/2-20, width: 160, height: 40)
            label.sizeToFit()
            label.center = CGPoint(x:self.view.frame.width/2,y:self.view.frame.height/2)
            self.view.addSubview(label)
        }
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var webView: WKWebView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

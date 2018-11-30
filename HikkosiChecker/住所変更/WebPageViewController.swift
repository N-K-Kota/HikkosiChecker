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
    override func viewDidLoad() {
        super.viewDidLoad()
         webView.navigationDelegate = self
         webView.uiDelegate = self
        if let u = url{
            self.navigationItem.title = pageTitle
            let request = URLRequest(url: URL(string: u)!)
            webView.load(request)
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

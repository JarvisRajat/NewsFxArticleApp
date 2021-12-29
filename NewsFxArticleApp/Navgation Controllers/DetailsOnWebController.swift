//
//  DetailsOnWebController.swift
//  NewsFxArticleApp
//
//  Created by Rajat Raj on 28/12/21.
//

import UIKit
import WebKit

class DetailsOnWebController: UIViewController {
    @IBOutlet private weak var webView: WKWebView!
    var path: String?
    var navTitle: String? = "FX Details"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonTitle = ""
        self.title = navTitle
        let request =  URLRequest(url: URL(string: path ?? "http://www.google.com")!)
        webView.load(request)
    }
}

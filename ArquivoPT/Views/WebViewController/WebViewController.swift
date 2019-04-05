//
//  WebViewController.swift
//  ArquivoPT
//
//  Created by Paulo Rocha on 02/04/2019.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var siteWebName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.load(URLRequest(url: URL(string: (siteWebName)!)!))
        // Do any additional setup after loading the view.
    }
    
}

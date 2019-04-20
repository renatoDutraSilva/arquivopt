//
//  WebViewController.swift
//  ArquivoPT
//
//  Created by Paulo Rocha on 02/04/2019.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate{

    @IBOutlet weak var websiteView: WKWebView!
    
    var siteWebName: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        ThemeFunctions.applyTheme(view: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let website = siteWebName{
            if let url = URL(string: website){
                websiteView.load(URLRequest(url: url))
            }
        }

        websiteView.allowsBackForwardNavigationGestures = true
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
}

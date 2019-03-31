//
//  TimeMachineViewController.swift
//  ArquivoPT
//
//  Created by Paulo Rocha on 30/03/2019.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import UIKit

class TimeMachineViewController: UIViewController {
    
    var siteId: UUID!
    var siteCategory: Category!
    var site: ModelSite?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SiteFunctions.readSite(by: siteId, category: siteCategory) { [weak self] (modelSite) in
            guard let self = self else { return }//if self is nil then terminate the function (for example, user left this page before the function ended)
            self.site = modelSite
            
            guard let modelSite = modelSite else {return}//if model is nil then terminate the function (for example, user lost connection to the data base)
            self.title = modelSite.siteName
        }

        // Do any additional setup after loading the view.
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

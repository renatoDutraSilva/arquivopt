//
//  ViewController.swift
//  ArquivoPT
//
//  Created by Renato Silva on 3/27/19.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        SiteFunctions.readSite(complition: { [weak self] in
            self?.mainTableView.reloadData()
        })
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Category.allCases.count - 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as! CustomTableViewCell
        
        cell.sectionLabel.text = Category.getRawValueFromIndex(index: indexPath.row).rawValue
        cell.sectionLabel.font = UIFont.boldSystemFont(ofSize: 19.0)
        //print("\(Category.getRawValueFromIndex(index: indexPath.row))")
        cell.sites = Data.mainSiteArray[Category.getRawValueFromIndex(index: indexPath.row)]!
        
        
        return cell
        
    }
    
    
}


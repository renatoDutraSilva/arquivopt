//
//  ViewController.swift
//  ArquivoPT
//
//  Created by Renato Silva on 3/27/19.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

//Ref: https://stackoverflow.com/questions/45030010/navigate-on-click-of-collectionview-cell-inside-tableview

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mainTableView.canCancelContentTouches = true
        SiteFunctions.readSites(completion: { [weak self] in
            self?.mainTableView.reloadData()
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
        mainTableView.reloadData()
    }
    
    fileprivate func applyTheme() {
        view.backgroundColor = Theme.current.background
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.current.accent]
        UINavigationBar.appearance().barTintColor = Theme.current.navigationBackground
        //        UINavigationBar.appearance().tintColor = Theme.current.accent (Altera a cor dos botões de navegação)
        //        UITabBar.appearance().tintColor = Theme.current.navigationBackground (Altera a core de selecção dos icons)
        UITabBar.appearance().backgroundColor = Theme.current.navigationBackground
    }
}

extension ViewController: CategoryRowDelegate {
    func cellTapped(site: ModelSite){

        let storyboard = UIStoryboard(name: String(describing: TimeMachineViewController.self), bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! TimeMachineViewController
        vc.site = site
        navigationController?.pushViewController(vc, animated: true)

    }
}

//extension ViewController: CustomCollectionViewCellDelegate {
//
//    func chicletButtonTapped(site: ModelSite) {
//
//        print("Got to delegate")
//        let storyboard = UIStoryboard(name: String(describing: TimeMachineViewController.self), bundle: nil)
//        let vc = storyboard.instantiateInitialViewController() as! TimeMachineViewController
//        vc.site = site
//        navigationController?.pushViewController(vc, animated: true)
//
//    }
//}

extension ViewController: UITableViewDataSource, UITableViewDelegate{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Category.allCases.count - 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as! CustomTableViewCell
       
        cell.delegate = self
        cell.backgroundColor = Theme.current.background
        cell.sectionLabel.text = Category.getRawValueFromIndex(index: indexPath.row).rawValue
        
        cell.sectionLabel.font = UIFont.boldSystemFont(ofSize: 22.0)

        cell.sites = Data.mainSiteArray[Category.getRawValueFromIndex(index: indexPath.row)]!
        
        print(Category.getRawValueFromIndex(index: indexPath.row))
        
        return cell
        
    }
    
}

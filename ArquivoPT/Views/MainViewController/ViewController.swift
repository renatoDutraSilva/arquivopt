//
//  ViewController.swift
//  ArquivoPT
//
//  Created by Renato Silva on 3/27/19.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

//Ref: https://stackoverflow.com/questions/45030010/navigate-on-click-of-collectionview-cell-inside-tableview

import UIKit

class ViewController: UIViewController, UISearchResultsUpdating {
    
    
    @IBOutlet weak var mainTableView: UITableView!
    var searchController: UISearchController!
    var filteredData: [Category: [ModelSite]]! = [.semCategoria: [ModelSite.placeHolder()]] {
        didSet{
            mainTableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ThemeFunctions.applyTheme(view: view)
        mainTableView.reloadData()
        searchController.searchBar.tintColor = Theme.current.accent
        searchController.searchBar.barTintColor = Theme.current.navigationBackground
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        SiteFunctions.readSites(completion: { [weak self] (filteredData: [Category: [ModelSite]]) in
            
            self!.filteredData = filteredData
            //self!.mainTableView.reloadData()
        })
        
        mainTableView.canCancelContentTouches = true
        
        // Initializing with searchResultsController set to nil means that
        // searchController will use this view controller to display the search results
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        
        searchController.searchBar.tintColor = Theme.current.accent
        searchController.searchBar.barTintColor = Theme.current.navigationBackground
        
        // If we are using this same view controller to present the results
        // dimming it out wouldn't make sense. Should probably only set
        // this to yes if using another controller to display the search results.
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.sizeToFit()
        mainTableView.tableHeaderView = searchController.searchBar
        
        // Sets this view controller as presenting view controller for the search interface
        definesPresentationContext = true
        print("Favorites: ")
        print(GlobalData.favoriteSiteArray)
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text {
            // Swift Ternary operator -> Condition ? valueToReturnIfTrue : valueToReturnIfFalse
            filteredData = searchText.isEmpty ? GlobalData.mainSiteArray : filteredData.filter({(category: Category, modelSiteArray: [ModelSite]) -> Bool in
                
                return modelSiteArray.contains(where: { (modelSite) -> Bool in
                    modelSite.siteName.lowercased().contains(searchText.lowercased())
                })
                
            })
            
//            print(filteredData)
            mainTableView.reloadData()

        }
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

extension ViewController: UITableViewDataSource, UITableViewDelegate{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.keys.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as! CustomTableViewCell
       
        cell.delegate = self
        cell.backgroundColor = Theme.current.background
        
        // Array(self.filteredData.keys) returns an array, instead of a collection of only the dictionary keys.
        // As such, we can then access each key with an Integer Subscript [0] or [indexPath.row]
        cell.sectionLabel.text = Array(self.filteredData.keys)[indexPath.row].rawValue
        
        cell.sectionLabel.font = UIFont.boldSystemFont(ofSize: 22.0)

        cell.sites = filteredData[Array(self.filteredData.keys)[indexPath.row]]! //?? [ModelSite.placeHolder()]
        cell.collectionView.backgroundColor = Theme.current.background
        
        
        return cell
        
    }
}


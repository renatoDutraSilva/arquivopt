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
    var categories = [Category]()
    
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
            
            for indexKey in 0 ... filteredData.keys.count - 1{
                if let sites = filteredData[Category.getRawValueFromIndex(index: indexKey)]{
                    for indexSite in 0 ... sites.count - 1{
                        if sites[indexSite].isFavorite {
                            GlobalData.favoriteSiteArray.append(sites[indexSite])
                        }
                    }
                }
            }
            
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
        searchController.searchBar.isTranslucent = true
        // Sets this view controller as presenting view controller for the search interface
        definesPresentationContext = true
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let modSearchText = searchController.searchBar.text {
            // Swift Ternary operator -> Condition ? valueToReturnIfTrue : valueToReturnIfFalse
            
//            filteredData = searchText.isEmpty ? GlobalData.mainSiteArray : filteredData.filter({
//                (category: Category, modelSiteArray: [ModelSite]) -> Bool in
//                let returnValue = modelSiteArray.contains(where: { (modelSite) -> Bool in
//                    modelSite.siteName.lowercased().contains(searchText.lowercased())
//                })
//                return returnValue
//            })
//
            
            let modSearchText = modSearchText.folding(options: .diacriticInsensitive, locale: .current).lowercased()
            
            print(modSearchText.lowercased())
            if modSearchText.isEmpty {
                filteredData = GlobalData.mainSiteArray
            } else{
                let filterDic = filteredData.filter({
                    (category: Category, modelSiteArray: [ModelSite]) -> Bool in
                    let returnValue = modelSiteArray.contains(where: { (modelSite) -> Bool in
                        modelSite.siteName.folding(options: .diacriticInsensitive, locale: .current).lowercased().contains(modSearchText)
                    })
                    return returnValue
                })
                
                filteredData = filterDic.mapValues { (modelSite) -> [ModelSite] in
                    var tempArray = [ModelSite]()
                    for site in modelSite{
                        if site.siteName.folding(options: .diacriticInsensitive, locale: .current).lowercased().contains(modSearchText) {
                            tempArray.append(site)
                        }
                    }
                    return tempArray
                }
                
            }

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
        
        var validCategoryIndex = [Int]()
        cell.delegate = self
        cell.backgroundColor = Theme.current.background
        
        // Array(self.filteredData.keys) returns an array, instead of a collection of only the dictionary keys.
        // As such, we can then access each key with an Integer Subscript [0] or [indexPath.row]

        for k in filteredData.keys{
            validCategoryIndex.append(Category.getIndexFromRawValue(rawValue: k))
        }
        validCategoryIndex = validCategoryIndex.sorted()

        cell.sectionLabel.text = Category.getRawValueFromIndex(index: validCategoryIndex[indexPath.row]).rawValue
        cell.sectionLabel.font = UIFont.boldSystemFont(ofSize: 22.0)
        
        if let sites = filteredData[Category.getRawValueFromIndex(index: validCategoryIndex[indexPath.row])]{
            cell.sites = sites
            
        }

        cell.collectionView.backgroundColor = Theme.current.background
        return cell
        
    }
}


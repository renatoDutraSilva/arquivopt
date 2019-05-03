//
//  FavoritesViewController.swift
//  ArquivoPT
//
//  Created by Paulo Rocha on 30/03/2019.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var favoritesTableView: UITableView!
    var favoriteCategories = [Category]()
    let noFavoritesLabel = UILabel()
    var favoriteSites = [ModelSite]()
    let emptyLabel = UILabel()
    let impact = UIImpactFeedbackGenerator()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ThemeFunctions.applyTheme(view: view)
        
        setFavoriteData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func setFavoriteData() {
        
        if let unwrappedCategories = GlobalData.getFavoriteCategories() {
            self.favoriteCategories = unwrappedCategories
            self.favoriteSites = GlobalData.favoriteSiteArray
            print(favoriteCategories)
            print(favoriteSites)
        }else {
            favoriteCategories.removeAll()
        }
        favoritesTableView.reloadData()

    }
    
    func shouldIndicateNoFavorites(_ shouldShow: Bool) {
        if shouldShow {
            emptyLabel.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
            emptyLabel.text = "Sem Favoritos definidos."
            emptyLabel.textAlignment = NSTextAlignment.center
            emptyLabel.textColor = Theme.current.accent
            self.favoritesTableView.backgroundView = emptyLabel
            self.favoritesTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            
        } else {
            emptyLabel.isHidden = false
            self.favoritesTableView.backgroundView = nil
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if favoriteCategories.isEmpty {
            shouldIndicateNoFavorites(true)
            return 0
        } else {
            shouldIndicateNoFavorites(false)
            return favoriteCategories.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return favoriteCategories[section].rawValue
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = Theme.current.favoritesTableHeader

        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = Theme.current.textColor
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return GlobalData.getFavoriteSites(ofCategory: favoriteCategories[section]).count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoritesTableViewCell
       
        let siteName = GlobalData.getFavoriteSites(ofCategory: favoriteCategories[indexPath.section])[indexPath.row].siteName
        let siteLogo = GlobalData.getFavoriteSites(ofCategory: favoriteCategories[indexPath.section])[indexPath.row].siteLogo
        let totalRecords = GlobalData.getFavoriteSites(ofCategory: favoriteCategories[indexPath.section])[indexPath.row].totalRecords
        let firstRecordedYear = GlobalData.getFavoriteSites(ofCategory: favoriteCategories[indexPath.section])[indexPath.row].firstRecordedYear
        let lastRecordedYear = GlobalData.getFavoriteSites(ofCategory: favoriteCategories[indexPath.section])[indexPath.row].lastRecordedYear
        
        cell.site = GlobalData.getFavoriteSites(ofCategory: favoriteCategories[indexPath.section])[indexPath.row]
        cell.selectionStyle = .none
        cell.delegate = self
        cell.siteNameLabel.text = siteName
        
        let logoImage = UIImage(named: siteLogo) ?? UIImage(named: "default.png")
        /*cell.logoImageView.frame = CGRect(x: 16, y: 16, width: cell.logoImage!.size.width, height: cell.logoImage!.size.height)*/
        //cell.logoImageView.image = logoImage
        
        cell.logoImage = logoImage
        cell.logoImageView.frame = CGRect(x: 16, y: 16, width: cell.logoImage!.size.width, height: cell.logoImage!.size.height)
        cell.logoImageView.image = cell.logoImage
        //cell.logoImageView.frame = CGRect(x: 16, y: 16, width: self.logoImage!.size.width, height: self.logoImage!.size.height)
        
        
        cell.recordLabel.text = String(totalRecords)
        cell.yearLabel.text = firstRecordedYear + " - " + lastRecordedYear
        
        
        
        //let screenSize = UIScreen.main.bounds
        //let screenWidth = screenSize.width
        //let screenHeight = screenSize.height
        
        //cell.chicletButton.bounds = CGRect(x: 0, y: 0, width: screenWidth, height: 188)
        //cell.chicletButton.applyGradient(colours: [Theme.current.cellGradientLight, Theme.current.cellGradientDark])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
            //print("REMOVED \(favoriteSites[indexPath.row].siteName) from \(favoriteCategories[indexPath.section])")
            
            let favoriteSite = GlobalData.getFavoriteSites(ofCategory: favoriteCategories[indexPath.section])[indexPath.row]
            
            favoriteSite.isFavorite = false

            GlobalData.favoriteSiteArray.removeAll { (site) -> Bool in
                return site.siteName == favoriteSite.siteName
            }
            
            if let index = GlobalData.favoriteID.firstIndex(of: favoriteSite.siteFileId) {
                GlobalData.favoriteID.remove(at: index)
            }
            UserDefaults.standard.set(GlobalData.favoriteID, forKey: GlobalKeys.favoriteKey)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)

           /* if GlobalData.getFavoriteSites(ofCategory: favoriteSite.category).isEmpty {
                tableView.deleteSections([indexPath.section], with: .automatic)
            }
            tableView.beginUpdates()
            tableView.endUpdates()*/
            
            setFavoriteData()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row at row: \(indexPath)")
        
        //cellTapped(site: GlobalData.getFavoriteSites(ofCategory: favoriteCategories[indexPath.section])[indexPath.row])
    }
    
}

extension FavoritesViewController: CustomFavoriteCellDelegate{
    func chicletButtonTapped(site: ModelSite) {
        //print("CellTapped!")
        let storyboard = UIStoryboard(name: String(describing: TimeMachineViewController.self), bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! TimeMachineViewController
        vc.site = site
        navigationController?.pushViewController(vc, animated: true)
        impact.impactOccurred()
    }
}

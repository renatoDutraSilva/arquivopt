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
        }
        favoritesTableView.reloadData()

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return favoriteCategories.count
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return favoriteCategories[section].rawValue
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if GlobalData.getFavoriteSites(ofCategory: favoriteCategories[section]).count == 0 {
            let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
            emptyLabel.text = "No Data"
            emptyLabel.textAlignment = NSTextAlignment.center
            emptyLabel.textColor = Theme.current.accent
            self.favoritesTableView.backgroundView = emptyLabel
            self.favoritesTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            return 0
            
        }else {
            return GlobalData.getFavoriteSites(ofCategory: favoriteCategories[section]).count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoritesTableViewCell
        let siteName = GlobalData.getFavoriteSites(ofCategory: favoriteCategories[indexPath.section])[indexPath.row].siteName
        let siteLogo = GlobalData.getFavoriteSites(ofCategory: favoriteCategories[indexPath.section])[indexPath.row].siteLogo
        
        cell.selectionStyle = .none
        
        cell.siteNameLabel.text = siteName
        
        let logoImage = UIImage(named: siteLogo) ?? UIImage(named: "presidencia.png")
        /*cell.logoImageView.frame = CGRect(x: 16, y: 16, width: cell.logoImage!.size.width, height: cell.logoImage!.size.height)*/
        cell.logoImageView.image = logoImage
        
        cell.recordLabel.text = "N/A"
        cell.yearLabel.text = "N/A" + " anos"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
            GlobalData.favoriteSiteArray[indexPath.row].isFavorite = false

            GlobalData.favoriteSiteArray.removeAll { (site) -> Bool in
                return site.siteName == favoriteSites[indexPath.row].siteName
            }

            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            favoriteSites.remove(at: indexPath.row)

            /*
            if let unwrappedCategories = GlobalData.getFavoriteCategories() {
                favoriteCategories = unwrappedCategories
                print (unwrappedCategories)
            }*/
            
            //print(favoriteCategories)
            //tableView.reloadData()*/
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row at row: \(indexPath)")
        
        cellTapped(site: favoriteSites[indexPath.row])
    }
    
}

extension FavoritesViewController: CategoryRowDelegate {
    func cellTapped(site: ModelSite){
        
        let storyboard = UIStoryboard(name: String(describing: TimeMachineViewController.self), bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! TimeMachineViewController
        vc.site = site
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

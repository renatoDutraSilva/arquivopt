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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ThemeFunctions.applyTheme(view: view)
        if let unwrappedCategories = GlobalData.getFavoriteCategories() {
            favoriteCategories = unwrappedCategories
        } else {
            // THIS CODE IS NOT WORKING
            noFavoritesLabel.frame = CGRect(x: (favoritesTableView.frame.width / 2) - 100, y: (favoritesTableView.frame.height / 2) - 22, width: 200, height: 44)
            noFavoritesLabel.text = "Não existem arquivos favoritos"
            noFavoritesLabel.layer.borderWidth = 3
            self.favoritesTableView.isHidden = true
            self.view.addSubview(noFavoritesLabel)
        }
        
        favoritesTableView.reloadData()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return favoriteCategories.count
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //else {return ""}
        return favoriteCategories[section].rawValue
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //guard let unwrappedCategories = GlobalData.getFavoriteCategories() else {return 0}
        return GlobalData.getFavoriteSites(ofCategory: favoriteCategories[section]).count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 182
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoritesTableViewCell
        cell.selectionStyle = .none
        cell.siteNameLabel.text = "Placeholder Site Name"
        
        cell.logoImage = UIImage(named: "gulbenkian.png")
        cell.logoImageView.frame = CGRect(x: 16, y: 16, width: cell.logoImage!.size.width, height: cell.logoImage!.size.height)
        cell.logoImageView.image = cell.logoImage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row at row: \(indexPath)")
    }
    
}

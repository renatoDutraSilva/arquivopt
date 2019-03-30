//
//  CustomTableViewCell.swift
//  ArquivoPT
//
//  Created by Renato Silva on 3/27/19.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    let layout = UICollectionViewFlowLayout()
    var sites = [Site]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layout.itemSize = CGSize(width: 140, height: 140)
        layout.scrollDirection = .horizontal
        layout.sectionHeadersPinToVisibleBounds = true
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundView?.backgroundColor = UIColor(displayP3Red: 55, green: 55, blue: 55, alpha: 100)
        
        //self.collectionView.isPagingEnabled = true
        
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

extension CustomTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
                
        /*switch sectionLabel!.text {
            
        case Category.artesECultura.rawValue:
            cell.siteNameLabel.text = Category.artesECultura.rawValue
            
        case Category.jornais.rawValue:
            cell.siteNameLabel.text = Category.jornais.rawValue
        case Category.desporto.rawValue:
            cell.siteNameLabel.text = Category.desporto.rawValue
        case Category.organismosSociais.rawValue:
            cell.siteNameLabel.text = Category.organismosSociais.rawValue
        case Category.radioETV.rawValue:
            cell.siteNameLabel.text = Category.radioETV.rawValue
            

        default: cell.siteNameLabel.text = "Sem categoria"
            
        }*/
        
        cell.site = sites[indexPath.row]
        cell.siteCardBackgroundView.image = UIImage(contentsOfFile: sites[indexPath.row].cardImage )
        cell.siteNameLabel.text = sites[indexPath.row].siteName
        
        return cell
        
    }
}

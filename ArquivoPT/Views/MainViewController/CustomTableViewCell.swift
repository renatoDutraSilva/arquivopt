//
//  CustomTableViewCell.swift
//  ArquivoPT
//
//  Created by Renato Silva on 3/27/19.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    weak var delegate: CategoryRowDelegate?

    let impact = UIImpactFeedbackGenerator()
    
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let layout = UICollectionViewFlowLayout()
    var sites = [ModelSite]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.canCancelContentTouches = true
        sectionLabel.textColor = Theme.current.accent
        //sectionLabel.backgroundColor = Theme.current.background
        
        layout.itemSize = CGSize(width: 150, height: 150)
        layout.scrollDirection = .horizontal
        layout.sectionHeadersPinToVisibleBounds = true
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        
        collectionView.backgroundColor = Theme.current.background
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundView?.backgroundColor = UIColor(displayP3Red: 100, green: 100, blue: 100, alpha: 100)
        
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
        
        cell.delegate = self
        cell.site = sites[indexPath.row]
        
        cell.logoImage = UIImage(named: sites[indexPath.row].siteLogo) ?? UIImage(named: "presidencia.png")
        cell.logoImageView.frame = CGRect(x: 16, y: 16, width: cell.logoImage!.size.width, height: cell.logoImage!.size.height)
        cell.logoImageView.image = cell.logoImage
        cell.siteNameLabel.text = sites[indexPath.row].siteName
        cell.isFavorite = sites[indexPath.row].isFavorite
        
        return cell
    }
}

extension CustomTableViewCell: CustomCollectionViewCellDelegate{
    func chicletButtonTapped(site: ModelSite) {

        if delegate != nil {
            delegate?.cellTapped(site: site)
        }
        impact.impactOccurred()
    }
    
    
}

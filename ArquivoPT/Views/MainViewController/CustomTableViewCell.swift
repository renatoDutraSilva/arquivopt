//
//  CustomTableViewCell.swift
//  ArquivoPT
//
//  Created by Renato Silva on 3/27/19.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    weak var delegate:CategoryRowDelegate?
    
    let impact = UIImpactFeedbackGenerator()
    
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    let layout = UICollectionViewFlowLayout()
    var sites = [ModelSite]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        sectionLabel.textColor = Theme.accent
        
        layout.itemSize = CGSize(width: 140, height: 140)
        layout.scrollDirection = .horizontal
        layout.sectionHeadersPinToVisibleBounds = true
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundView?.backgroundColor = UIColor(displayP3Red: 55, green: 55, blue: 55, alpha: 100)
        
//        self.collectionView.reloadData()
        
        //self.collectionView.isPagingEnabled = true

        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

extension CustomTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
//    , UICollectionViewDelegateFlowLayout
    
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
        print(cell.site?.siteName)
        print(sites[indexPath.row].siteName)
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if delegate != nil {
            delegate?.cellTapped(site: sites[indexPath.row])
        }
        impact.impactOccurred()
        
//        let cell = collectionView.cellForItem(at: indexPath)
//        
//        UIView.animate(withDuration: 0.5,
//                       animations: {
//                        //Fade-out
//                        cell?.alpha = 0.1
//                        cell?.contentView.frame = CGRect(x: 3, y: 14, width: 100, height: 100)
//        }) { (completed) in
//            UIView.animate(withDuration: 0.5,
//                           animations: {
//                            //Fade-out
//                            cell?.alpha = 1
//            })
//        }
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let cell = collectionView.cellForItem(at: indexPath)
//        return CGSize(width: (cell?.frame.size.width)! * 0.4, height: (cell?.frame.size.height)! * 0.4);
//    }
}

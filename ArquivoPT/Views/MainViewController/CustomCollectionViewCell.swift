//
//  CustomCollectionViewCell.swift
//  ArquivoPT
//
//  Created by Renato Silva on 3/27/19.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    let siteLogo = UIImage(contentsOfFile: "dnLogo.png")
    
    @IBOutlet weak var chicletView: UIView!
    @IBOutlet weak var siteCardImageView: UIImageView!
    @IBOutlet weak var siteNameView: UIView!
    @IBOutlet weak var siteCardBackgroundView: UIImageView!
    
    var site: ModelSite? = nil
    
    let siteNameLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        generateChiclet()


    }
    
    
    
    func toggleShowBadge() {
        self.siteNameView.isHidden = false
    }
    
    func generateChiclet(){
        
        siteCardBackgroundView.image = UIImage(contentsOfFile: "siteCardBackground.png")
        siteCardBackgroundView.bounds = chicletView.layer.bounds
        
        siteNameView.addBlurEffect()
        siteNameView.frame = CGRect(x: 0 , y: chicletView.frame.maxY - 10 , width: chicletView.frame.maxX + 28, height: 40)
        siteNameView.clipsToBounds = true
        
        siteNameLabel.textColor = UIColor.white
        siteNameLabel.frame = CGRect(x: 8, y: 0, width: siteNameView.bounds.width, height: siteNameView.bounds.height)
        siteNameLabel.font = UIFont.systemFont(ofSize: 14)
        siteNameLabel.text = site?.siteName
        
        siteNameView.addSubview(siteNameLabel)
        
        chicletView.addShadowAndRoundedCorners()
        chicletView.frame = CGRect(x: 0, y: 0, width: 140, height: 140)
        chicletView.backgroundColor = Theme.current.chicletBackground
        chicletView.addSubview(siteCardBackgroundView)
        chicletView.addSubview(siteNameView)
    }
}

protocol CategoryRowDelegate: class {
    func cellTapped(site: ModelSite)
}

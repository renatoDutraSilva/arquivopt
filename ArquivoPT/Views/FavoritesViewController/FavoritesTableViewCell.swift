//
//  FavoritesTableViewCell.swift
//  ArquivoPT
//
//  Created by Renato Silva on 4/9/19.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    let chicletView = UIView()
    let labelBlurView = UIView()
    let logoImageView = UIImageView()
    var logoImage: UIImage?
    let siteNameLabel = UILabel()
    let yearNumberView = UIView()
    let recordNumberView = UIView()
    let recordLabel = UILabel()
    let yearLabel = UILabel()
    


    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = Theme.current.background
        generateChiclet()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func generateChiclet(){
        
        self.chicletView.frame = CGRect(x: 16, y: 16, width: self.frame.width - 32 , height: 150)
        self.chicletView.layer.cornerRadius = 14
        self.chicletView.layer.masksToBounds = true
        self.chicletView.applyGradient(colours: [Theme.current.cellGradientLight, Theme.current.cellGradientDark])

        labelBlurView.frame = CGRect(x: 0, y: chicletView.frame.height - chicletView.frame.height/3, width: chicletView.frame.width, height: chicletView.frame.height/3)
        labelBlurView.addBlurEffect()
        
        siteNameLabel.frame = CGRect(x: 16, y: chicletView.frame.height - chicletView.frame.height/3, width: chicletView.frame.width - 32, height: chicletView.frame.height/3)
        siteNameLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        siteNameLabel.textAlignment = NSTextAlignment.left
        siteNameLabel.numberOfLines = 0
        siteNameLabel.textColor = UIColor.white
        
        yearNumberView.frame = CGRect(x: chicletView.frame.width / 2.5 , y: 16, width: chicletView.frame.width - chicletView.frame.width / 1.35, height: chicletView.frame.height/2.5)
        yearNumberView.layer.borderWidth = 1
        
        recordNumberView.frame = CGRect(x: chicletView.frame.width / 1.5 , y: 16, width: chicletView.frame.width - chicletView.frame.width / 1.35, height: chicletView.frame.height/2.5)
        recordNumberView.layer.borderWidth = 1
        
        
        
        self.chicletView.addSubview(yearNumberView)
        self.chicletView.addSubview(recordNumberView)
        self.chicletView.addSubview(logoImageView)

        self.chicletView.addSubview(self.labelBlurView)
        self.chicletView.addSubview(siteNameLabel)

        self.contentView.addSubview(chicletView)
    }

}

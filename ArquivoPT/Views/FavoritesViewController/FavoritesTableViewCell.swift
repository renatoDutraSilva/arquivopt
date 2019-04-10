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
        
        self.chicletView.frame = CGRect(x: 16, y: 16, width: self.frame.width - 70 , height: 150)
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
        
        yearNumberView.frame = CGRect(x: chicletView.frame.width / 1.47 , y: 16, width: chicletView.frame.width - chicletView.frame.width / 1.37, height: chicletView.frame.height/2.5)
        //yearNumberView.layer.borderWidth = 3
        
        recordNumberView.frame = CGRect(x: chicletView.frame.width / 2.6 , y: 16, width: chicletView.frame.width - chicletView.frame.width / 1.37, height: chicletView.frame.height/2.5)
        //recordNumberView.layer.borderWidth = 1
        
        
        recordLabel.frame = CGRect(x: 0, y: 0, width: recordNumberView.frame.width, height: recordNumberView.frame.height / 2)
        //recordLabel.layer.borderWidth = 1
        recordLabel.textColor = UIColor.white
        recordLabel.font = UIFont.systemFont(ofSize: 20)
        
        yearLabel.frame = CGRect(x: 0, y: 0, width: yearNumberView.frame.width, height: yearNumberView.frame.height / 2)
        //yearLabel.layer.borderWidth = 1
        yearLabel.textColor = UIColor.white
        yearLabel.font = UIFont.systemFont(ofSize: 20)
        
        //yearLabel = UILabel()
        
        let recordDescriptionLabel = UILabel(frame: CGRect(x: 0, y: recordNumberView.frame.height / 2, width: recordNumberView.frame.width, height: recordNumberView.frame.height / 2))
        
        let yearDescriptionLabel = UILabel(frame: CGRect(x: 0, y: yearNumberView.frame.height / 2, width: yearNumberView.frame.width, height: yearNumberView.frame.height / 2))
        
        //recordDescriptionLabel.layer.borderWidth = 1
        recordDescriptionLabel.textColor = Theme.current.cellGradientLight
        recordDescriptionLabel.text = "REGISTOS"
        recordDescriptionLabel.font = UIFont.boldSystemFont(ofSize: 17)
        //recordDescriptionLabel.layer.opacity = 50
        
        //yearDescriptionLabel.layer.borderWidth = 1
        yearDescriptionLabel.textColor = Theme.current.cellGradientLight
        yearDescriptionLabel.text = "HISTÓRICO"
        yearDescriptionLabel.font = UIFont.boldSystemFont(ofSize: 17)
        //yearDescriptionLabel.layer.opacity = 50
        
        let recordSeparator = UIView(frame: CGRect(x: 0 / 2.6, y: recordDescriptionLabel.frame.minY, width: recordNumberView.frame.width / 1.5, height: 4))
        recordSeparator.layer.cornerRadius = 2
        recordSeparator.layer.masksToBounds = true
        recordSeparator.applyGradient(colours: [Theme.current.textColor, UIColor(named: "LightAccent")!])
        recordSeparator.layer.opacity = 50
        
        let yearSeparator = UIView(frame: CGRect(x: 0 / 2.6, y: yearDescriptionLabel.frame.minY, width: yearNumberView.frame.width / 1.5, height: 4))
        yearSeparator.layer.cornerRadius = 2
        yearSeparator.layer.masksToBounds = true
        yearSeparator.applyGradient(colours: [Theme.current.textColor, UIColor(named: "LightAccent")!])
        yearSeparator.layer.opacity = 50
        
        
        self.recordNumberView.addSubview(recordDescriptionLabel)
        self.recordNumberView.addSubview(recordLabel)
        self.recordNumberView.addSubview(recordSeparator)
        
        self.yearNumberView.addSubview(yearDescriptionLabel)
        self.yearNumberView.addSubview(yearSeparator)
        self.yearNumberView.addSubview(yearLabel)
        
        
        self.chicletView.addSubview(yearNumberView)
        self.chicletView.addSubview(recordNumberView)
        self.chicletView.addSubview(logoImageView)

        self.chicletView.addSubview(self.labelBlurView)
        self.chicletView.addSubview(siteNameLabel)

        self.contentView.addSubview(chicletView)
    }

}

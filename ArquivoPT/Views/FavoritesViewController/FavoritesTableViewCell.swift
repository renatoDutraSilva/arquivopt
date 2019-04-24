//
//  FavoritesTableViewCell.swift
//  ArquivoPT
//
//  Created by Renato Silva on 4/9/19.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import UIKit

protocol CustomFavoriteCellDelegate: class {
    func chicletButtonTapped(site: ModelSite)
}

class FavoritesTableViewCell: UITableViewCell {
    
    let chicletButton = UIButton()
    let logoImageView = UIImageView()
    var logoImage: UIImage?

    let recordLabel = UILabel()
    let yearLabel = UILabel()
    
    let recordDescriptionLabel = UILabel()
    let yearDescriptionLabel = UILabel()
    
    let blurView = PassthroughView()
    let siteNameLabel = UILabel()
    
    var site: ModelSite?
    var delegate: CustomFavoriteCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = Theme.current.background
        generateChiclet()
        chicletButton.startAnimatingPressActions()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func generateChiclet(){
        
        chicletButton.frame = CGRect(x: 16 , y: 16, width: UIScreen.main.bounds.width - 32, height: self.contentView.bounds.height - 32)
        
        chicletButton.applyGradient(colours: [Theme.current.cellGradientLight, Theme.current.cellGradientDark])
        chicletButton.addTarget(self, action: #selector(chicletButtonTouchUpInside), for: [.touchUpInside])
        
        chicletButton.addRoundedCorners()
        self.layer.addShadow(followingPathOf: chicletButton)
        self.layer.shadowColor = UIColor.darkGray.cgColor
        
        siteNameLabel.frame = CGRect(x: 16, y: chicletButton.frame.height - chicletButton.frame.height/3, width: chicletButton.frame.width - 32, height: chicletButton.frame.height/3)
        siteNameLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        siteNameLabel.textAlignment = NSTextAlignment.left
        siteNameLabel.numberOfLines = 0
        siteNameLabel.textColor = UIColor.white
        
        blurView.frame = CGRect(x: 0, y: chicletButton.frame.height - chicletButton.frame.height/3, width: chicletButton.frame.width, height: chicletButton.frame.height/3)
        blurView.addBlurEffect()
       
        recordLabel.textColor = UIColor.white
        recordLabel.font = UIFont.systemFont(ofSize: 20)
        recordLabel.frame = CGRect(x: (chicletButton.frame.width / 2) - 40, y: 32, width: 80, height: 22)
        
        yearLabel.textColor = UIColor.white
        yearLabel.font = UIFont.systemFont(ofSize: 20)
        yearLabel.frame = CGRect(x: (chicletButton.frame.width / 1.5) , y: 32, width: 90, height: 22)

        recordDescriptionLabel.text = "REGISTOS"
        recordDescriptionLabel.textColor = Theme.current.cellGradientDark
        recordDescriptionLabel.font = UIFont.boldSystemFont(ofSize: 16)
        recordDescriptionLabel.frame = CGRect(x: (chicletButton.frame.width / 2) - 40, y: 56, width: 80, height: 22)
        //recordDescriptionLabel.layer.borderWidth = 1
        
        yearDescriptionLabel.text = "HISTÓRICO"
        yearDescriptionLabel.textColor = Theme.current.cellGradientDark
        yearDescriptionLabel.font = UIFont.boldSystemFont(ofSize: 16)
        yearDescriptionLabel.frame = CGRect(x: (chicletButton.frame.width / 1.5) , y: 56, width: 90, height: 22)
        //yearDescriptionLabel.layer.borderWidth = 1
        
        chicletButton.addSubview(logoImageView)
        chicletButton.addSubview(yearDescriptionLabel)
        chicletButton.addSubview(yearLabel)
        chicletButton.addSubview(recordDescriptionLabel)
        chicletButton.addSubview(recordLabel)
        chicletButton.addSubview(blurView)
        chicletButton.addSubview(siteNameLabel)
        
        self.contentView.layer.addShadow(followingPathOf: chicletButton)
        self.addSubview(chicletButton)
 
    }
    
    @IBAction func chicletButtonTouchUpInside(_ sender: UIButton) {
        
        guard let unwrappedSite = self.site else {return}
        //print("Got past guard")
        delegate?.chicletButtonTapped(site: unwrappedSite)
    }

}

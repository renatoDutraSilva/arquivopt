//
//  FavoritesTableViewCell.swift
//  ArquivoPT
//
//  Created by Renato Silva on 4/9/19.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var chicletView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var recordDescriptionLabel: UILabel!
    @IBOutlet weak var yearDescriptionLabel: UILabel!
    
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var siteNameLabel: UILabel!
    
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
        
        chicletView.layer.masksToBounds = true
        chicletView.applyGradient(colours: [Theme.current.cellGradientLight, Theme.current.cellGradientDark])
       

        blurView.frame = CGRect(x: 0, y: chicletView.frame.height - chicletView.frame.height/3, width: chicletView.frame.width, height: chicletView.frame.height/3)
        blurView.addBlurEffect()
       
        siteNameLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        siteNameLabel.textAlignment = NSTextAlignment.left
        siteNameLabel.numberOfLines = 0
        siteNameLabel.textColor = UIColor.white
        
        recordLabel.textColor = UIColor.white
        recordLabel.font = UIFont.systemFont(ofSize: 20)
        
        yearLabel.textColor = UIColor.white
        yearLabel.font = UIFont.systemFont(ofSize: 20)

        recordDescriptionLabel.text = "REGISTOS"
        recordDescriptionLabel.textColor = Theme.current.cellGradientLight
        recordDescriptionLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        yearDescriptionLabel.text = "HISTÓRICO"
        yearDescriptionLabel.textColor = Theme.current.cellGradientLight
        yearDescriptionLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
 
    }

}

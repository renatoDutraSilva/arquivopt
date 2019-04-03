//
//  CustomCollectionViewCell.swift
//  ArquivoPT
//
//  Created by Renato Silva on 3/27/19.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import UIKit

protocol CategoryRowDelegate: class {
    func cellTapped(site: ModelSite)
}

protocol CustomCollectionViewCellDelegate: class {
    func chicletButtonTapped(site: ModelSite)
}

class CustomCollectionViewCell: UICollectionViewCell {
    
    var siteLogoFilename: String?
    let siteNameLabel = UILabel()
    var chicletButton = UIButton()
    var delegate: CustomCollectionViewCellDelegate?
    var site: ModelSite? = nil
    let logoImageView = UIImageView()

    override func awakeFromNib() {
        super.awakeFromNib()
        generateChiclet()
        chicletButton.startAnimatingPressActions()
    }
    
    func generateChiclet(){
    
        chicletButton.frame = CGRect(x: 0, y: 0, width: self.frame.width + 32, height: self.frame.height + 32)
        //chicletButton.setBackgroundImage(UIImage(named: siteLogoFilename ?? "publico.png"), for: .normal)
        //chicletButton.layer.backgroundColor = UIColor.white.cgColor
        //chicletButton.layer.borderWidth = 0.5
        //chicletButton.layer.borderColor = UIColor.white.cgColor
        
        
        //logoImageView.layer.borderWidth = 1
        let logoImage = UIImage(named: siteLogoFilename ?? "publico.png")!
        logoImageView.frame = CGRect(x: 16, y: 16, width: logoImage.size.width, height: logoImage.size.height)
        logoImageView.image = logoImage
        chicletButton.addShadowAndRoundedCorners()
        
        self.chicletButton.applyGradient(colours: [Theme.current.cellGradientLight, Theme.current.cellGradientDark])
        
        chicletButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 100).cgColor
        chicletButton.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        chicletButton.layer.shadowOpacity = 0.25
        chicletButton.layer.shadowRadius = 7
        chicletButton.layer.masksToBounds = true
        chicletButton.layer.cornerRadius = 14.0
        
        siteNameLabel.frame = CGRect(x: 16, y: chicletButton.frame.height - chicletButton.frame.height/3, width: chicletButton.frame.width - 32, height: chicletButton.frame.height/3)
        siteNameLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        siteNameLabel.textAlignment = NSTextAlignment.left
        siteNameLabel.textColor = UIColor.white
        
        chicletButton.addTarget(self, action: #selector(chicletButtonTouchUpInside), for: [.touchUpInside])
        chicletButton.addSubview(logoImageView)
        chicletButton.addSubview(siteNameLabel)
        
        self.addSubview(chicletButton)

    }
    
    @IBAction func chicletButtonTouchUpInside(_ sender: UIButton) {
        
        guard let unwrappedSite = self.site else {return}
        print("Got past guard")
        delegate?.chicletButtonTapped(site: unwrappedSite)
    }
}

extension UIButton {
    
    func startAnimatingPressActions() {
        addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(animateUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    }
    
    @objc private func animateDown(sender: UIButton) {
        animate(sender, transform: CGAffineTransform.identity.scaledBy(x: 0.90, y: 0.90))
    }
    
    @objc private func animateUp(sender: UIButton) {
        animate(sender, transform: .identity)
    }
    
    private func animate(_ button: UIButton, transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 3,
                       options: [.curveEaseInOut],
                       animations: {
                        button.transform = transform
        }, completion: nil)
    }
    
}

extension UITableView {
    
    override open func touchesShouldCancel(in view: UIView) -> Bool {
        
        if view is UIControl {
            return true
        }
        return super.touchesShouldCancel(in: view)
    }
}

extension UICollectionView {
    
    override open func touchesShouldCancel(in view: UIView) -> Bool {
        
        if view is UIControl {
            return true
        }
        return super.touchesShouldCancel(in: view)
    }
}

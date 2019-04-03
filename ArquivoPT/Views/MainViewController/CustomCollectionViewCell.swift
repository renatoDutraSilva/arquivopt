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
    
    let siteLogo = UIImage(contentsOfFile: "dnLogo.png")
    let siteNameLabel = UILabel()
    var chicletButton = UIButton()
    var delegate: CustomCollectionViewCellDelegate?
    var site: ModelSite? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        generateChiclet()
        chicletButton.startAnimatingPressActions()
        
    }
    
    func generateChiclet(){
    
        chicletButton.setImage(UIImage(contentsOfFile: site?.siteLogo ?? "dnLogo.png"), for: .normal)
        chicletButton.frame = CGRect(x: 0, y: 0, width: self.frame.width + 32, height: self.frame.height + 32)
        chicletButton.titleLabel!.text = site?.siteName
        chicletButton.tintColor = UIColor.white
        chicletButton.backgroundColor = UIColor.black
        
        chicletButton.addTarget(self, action: #selector(chicletButtonTouchUpInside), for: [.touchUpInside])
        
        chicletButton.addShadowAndRoundedCorners()
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

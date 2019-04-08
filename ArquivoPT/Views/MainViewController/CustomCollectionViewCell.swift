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
    
    let siteNameLabel = UILabel()
    let labelBlurView = PassthroughView()
    let chicletButton = UIButton()
    var delegate: CustomCollectionViewCellDelegate?
    var site: ModelSite?
    let logoImageView = UIImageView()
    var logoImage: UIImage?
    var favoriteIndicator = UIImageView()
    var isFavorite: Bool = false {
        didSet{
            if isFavorite{
                favoriteIndicator.frame = CGRect(x: chicletButton.frame.width - 40, y: 16, width: 26, height: 22)
                favoriteIndicator.image = UIImage(named:"favoriteIconSelected.png")
                chicletButton.addSubview(favoriteIndicator)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        generateChiclet()
        chicletButton.startAnimatingPressActions()
    }
    
    func generateChiclet(){
    
        chicletButton.frame = CGRect(x: 0, y: 0, width: self.frame.width + 32, height: self.frame.height + 32)
        chicletButton.addShadowAndRoundedCorners()
        chicletButton.applyGradient(colours: [Theme.current.cellGradientLight, Theme.current.cellGradientDark])
        chicletButton.addTarget(self, action: #selector(chicletButtonTouchUpInside), for: [.touchUpInside])

        siteNameLabel.frame = CGRect(x: 16, y: chicletButton.frame.height - chicletButton.frame.height/3, width: chicletButton.frame.width - 32, height: chicletButton.frame.height/3)
        siteNameLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        siteNameLabel.textAlignment = NSTextAlignment.left
        siteNameLabel.numberOfLines = 0
        siteNameLabel.textColor = UIColor.white
        
        labelBlurView.frame = CGRect(x: 0, y: chicletButton.frame.height - chicletButton.frame.height/3, width: chicletButton.frame.width, height: chicletButton.frame.height/3)
        labelBlurView.addBlurEffect()

        chicletButton.addSubview(logoImageView)
        chicletButton.addSubview(labelBlurView)
        chicletButton.addSubview(siteNameLabel)
        
        self.addSubview(chicletButton)

    }
    
    @IBAction func chicletButtonTouchUpInside(_ sender: UIButton) {
        
        guard let unwrappedSite = self.site else {return}
        //print("Got past guard")
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

// override HitTest method for BlurView
class PassthroughView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self ? view : nil
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

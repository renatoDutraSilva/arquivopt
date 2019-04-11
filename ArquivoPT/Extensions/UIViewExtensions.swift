//
//  UIViewExtensions.swift
//  ArquivoPT
//
//  Created by Paulo Rocha on 30/03/2019.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import UIKit

extension UIView {
    
    func addRoundedCorners() {
        
        self.layer.cornerRadius = 14.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
    }
    
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: Theme.current.blurEffectStyle)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
    
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours, locations: nil)
    }
    
    func applyGradient(_ colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
        
    }
    
    
}

extension CALayer {
    func addShadow(followingPathOf contentView: UIView) {
        self.shadowColor = Theme.current.cellGradientDark.cgColor //UIColor.lightGray.cgColor
        self.shadowOffset = CGSize(width: 0.0, height: 2.5)
        self.shadowRadius = 4
        self.shadowOpacity = 1.0
        self.masksToBounds = false
        //self.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        self.backgroundColor = UIColor.clear.cgColor
    }
}

//
//  UIViewExtensions.swift
//  ArquivoPT
//
//  Created by Paulo Rocha on 30/03/2019.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import UIKit

extension UIView {
    
    func addShadowAndRoundedCorners() {
        layer.shadowOffset = CGSize(width: 1, height: 2)
        layer.shadowRadius = 7.0
        layer.shadowOpacity = 0.25
        layer.masksToBounds = true
        layer.cornerRadius = 14
    }
    
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
}

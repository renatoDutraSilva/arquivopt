//
//  LightTheme.swift
//  ArquivoPT
//
//  Created by Paulo Rocha on 02/04/2019.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import UIKit

class LightTheme: ThemeProtocol {
    var accent: UIColor = UIColor(named: "LightAccent")!
    var textColor: UIColor = UIColor(named: "Accent")!
    var background: UIColor = UIColor(named: "LightBackground")!
    var navigationBackground: UIColor = UIColor(named: "LightNavigationBackground")!
    var chicletBackground: UIColor = UIColor(named: "LightChicletBackground")!
    
    // Cell Gradients
    var cellGradientLight: UIColor = UIColor(named: "CellGradientLight")!
    var cellGradientDark: UIColor = UIColor(named: "CellGradientDark")!
    
    var blurEffectStyle = UIBlurEffect.Style.dark
}


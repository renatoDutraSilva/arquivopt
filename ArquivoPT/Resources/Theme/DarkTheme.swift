//
//  DarkTheme.swift
//  ArquivoPT
//
//  Created by Paulo Rocha on 02/04/2019.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import UIKit


class DarkTheme: ThemeProtocol {
    var accent: UIColor =  UIColor(named: "Accent")!
    var textColor: UIColor = UIColor(named: "Accent")!
    var background: UIColor =  UIColor(named: "Background")!
    var navigationBackground: UIColor =  UIColor(named: "NavigationBackground")!
    var chicletBackground: UIColor =  UIColor(named: "ChicletBackground")!
    
    // Cell Gradients
    var cellGradientLight: UIColor = UIColor(named: "CellGradientLight")!
    var cellGradientDark: UIColor = UIColor(named: "CellGradientDark")!
}

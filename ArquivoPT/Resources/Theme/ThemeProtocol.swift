//
//  ThemeProtocol.swift
//  ArquivoPT
//
//  Created by Paulo Rocha on 02/04/2019.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import UIKit

protocol ThemeProtocol {
    var accent: UIColor { get }
    var textColor: UIColor { get }
    var background: UIColor { get }
    var navigationBackground: UIColor { get }
    var chicletBackground: UIColor { get }
    
    // Cell Gradients
    var cellGradientLight: UIColor { get }
    var cellGradientDark: UIColor { get }
}

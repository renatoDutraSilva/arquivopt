//
//  ThemeFunctions.swift
//  ArquivoPT
//
//  Created by Paulo Rocha on 06/04/2019.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import Foundation
import UIKit

class ThemeFunctions{
    
    static func applyTheme(view: UIView) {
        view.backgroundColor = Theme.current.background
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.current.accent]
        UINavigationBar.appearance().barTintColor = Theme.current.navigationBackground
        UINavigationBar.appearance().tintColor = Theme.current.accent //(Altera a cor dos botões de navegação)
        UITabBar.appearance().tintColor = Theme.current.accent //(Altera a core de selecção dos icons)
        UITabBar.appearance().backgroundColor = Theme.current.navigationBackground
    }
    
}

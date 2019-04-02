//
//  FavoritesViewController.swift
//  ArquivoPT
//
//  Created by Paulo Rocha on 30/03/2019.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController{


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyTheme()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
    }

    fileprivate func applyTheme() {
        view.backgroundColor = Theme.current.background
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.current.accent]
        UINavigationBar.appearance().barTintColor = Theme.current.navigationBackground
        //        UINavigationBar.appearance().tintColor = Theme.current.accent (Altera a cor dos botões de navegação)
        //        UITabBar.appearance().tintColor = Theme.current.navigationBackground (Altera a core de selecção dos icons)
        UITabBar.appearance().backgroundColor = Theme.current.navigationBackground
    }
}

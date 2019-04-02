//
//  SettingsViewController.swift
//  ArquivoPT
//
//  Created by Paulo Rocha on 30/03/2019.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyTheme()

    }
    
    fileprivate func applyTheme() {
        view.backgroundColor = Theme.current.background
        themeLable.textColor = Theme.current.accent
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.current.accent]
        UINavigationBar.appearance().barTintColor = Theme.current.navigationBackground
        //        UINavigationBar.appearance().tintColor = Theme.current.accent (Altera a cor dos botões de navegação)
        //        UITabBar.appearance().tintColor = Theme.current.navigationBackground (Altera a core de selecção dos icons)
        UITabBar.appearance().backgroundColor = Theme.current.navigationBackground
    }
    
    @IBOutlet weak var themeLable: UILabel!
    
    @IBAction func themeChange(_ sender: UISwitch) {
        Theme.current = sender.isOn ? LightTheme() : DarkTheme()
        
        UserDefaults.standard.set(sender.isOn, forKey: "LightTheme")
        applyTheme()
    }
    



}

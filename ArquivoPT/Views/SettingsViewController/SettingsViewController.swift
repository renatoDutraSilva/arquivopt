//
//  SettingsViewController.swift
//  ArquivoPT
//
//  Created by Paulo Rocha on 30/03/2019.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {


    @IBOutlet weak var themeLable: UILabel!
    @IBOutlet weak var themeSwitch: UISwitch!
    
    let themeKey = "LightTheme"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ThemeFunctions.applyTheme(view: view)
        themeLable.textColor = Theme.current.accent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let themeMode = UserDefaults.standard.value(forKey: themeKey){
            themeSwitch.isOn = themeMode as! Bool 
        }
    }
    

    @IBAction func themeChange(_ sender: UISwitch) {
        Theme.current = sender.isOn ? LightTheme() : DarkTheme()
        
        UserDefaults.standard.set(sender.isOn, forKey: themeKey)
        print("Theme Changed")
        ThemeFunctions.applyTheme(view: view)
        navigationController?.navigationBar.barTintColor = Theme.current.navigationBackground
    }
    



}

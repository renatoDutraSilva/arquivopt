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
    
    @IBOutlet weak var timeIntervalLabel: UILabel!
    @IBOutlet weak var timeIntervalSwitch: UISwitch!
    
    @IBOutlet weak var initialDateTextField: UITextField!
    @IBOutlet weak var finalDateTextField: UITextField!
    
    private var initialDatePicker: UIDatePicker?
    private var finalDatePicker: UIDatePicker?
    
    let themeKey = "LightTheme"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ThemeFunctions.applyTheme(view: view)
        themeLable.textColor = Theme.current.accent
        timeIntervalLabel.textColor = Theme.current.accent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpPickers()
        creatToolbar()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        
        
        if let themeMode = UserDefaults.standard.value(forKey: themeKey){
            themeSwitch.isOn = themeMode as! Bool 
        }
        
    }
    
    @IBAction func timeIntervalSetChange(_ sender: UISwitch) {
    }
    
    @IBAction func themeChange(_ sender: UISwitch) {
        Theme.current = sender.isOn ? LightTheme() : DarkTheme()
        
        UserDefaults.standard.set(sender.isOn, forKey: themeKey)
        print("Theme Changed")
        ThemeFunctions.applyTheme(view: view)
        navigationController?.navigationBar.barTintColor = Theme.current.navigationBackground
    }
    
    func setUpPickers() {
        
        
        
        initialDatePicker = UIDatePicker()
        initialDatePicker?.datePickerMode = .date
//        initialDatePicker?.minimumDate = Date(from: "01/01/1996")
        
        finalDatePicker = UIDatePicker()
        finalDatePicker?.datePickerMode = .date
        
        
        initialDateTextField.inputView = initialDatePicker
        initialDatePicker?.addTarget(self, action: #selector(SettingsViewController.initialDateChanged(datePicker:)), for: .valueChanged)
        
        finalDateTextField.inputView = finalDatePicker
        finalDatePicker?.addTarget(self, action: #selector(SettingsViewController.finalDateChanged(datePicker:)), for: .valueChanged)
    }
    
    func creatToolbar(){
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        //Customization
        toolBar.barTintColor = .darkGray
        toolBar.tintColor = .white
        
        let doneButton = UIBarButtonItem(title: "Fechar", style: .plain, target: self, action: #selector(SettingsViewController.dismissKeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        initialDateTextField.inputAccessoryView = toolBar
        finalDateTextField.inputAccessoryView = toolBar
        
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        dismissKeyboard()
    }
    
    @objc func initialDateChanged(datePicker: UIDatePicker){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyy"
        initialDateTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    
    @objc func finalDateChanged(datePicker: UIDatePicker){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyy"
        finalDateTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
}

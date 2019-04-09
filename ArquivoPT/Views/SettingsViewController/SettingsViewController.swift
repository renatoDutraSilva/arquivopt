//
//  SettingsViewController.swift
//  ArquivoPT
//
//  Created by Paulo Rocha on 30/03/2019.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {


    @IBOutlet weak var themeLable: UILabel!
    @IBOutlet weak var themeSwitch: UISwitch!
    
    @IBOutlet weak var timeIntervalLabel: UILabel!
    @IBOutlet weak var timeIntervalSwitch: UISwitch!
    
    @IBOutlet weak var initialDateTextField: UITextField!
    @IBOutlet weak var finalDateTextField: UITextField!
    
    @IBOutlet weak var initialDateLabel: UILabel!
    
    @IBOutlet weak var initialDateCalendarPicker: UIDatePicker!
    
    private var initialDatePicker: UIDatePicker?
    private var finalDatePicker: UIDatePicker?
    
    let themeKey = "DarkTheme"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ThemeFunctions.applyTheme(view: view)
        themeLable.textColor = Theme.current.accent
        timeIntervalLabel.textColor = Theme.current.accent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        NEW FUNCTIONS
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        datePickerChanged()
        
//        OLD FUNCTIONS
        
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
        Theme.current = sender.isOn ? DarkTheme() : LightTheme()
        
        UserDefaults.standard.set(sender.isOn, forKey: themeKey)
        ThemeFunctions.applyTheme(view: view)
        navigationController?.navigationBar.barTintColor = Theme.current.navigationBackground
    }
    
    
    @IBAction func initialPickerChanged(_ sender: UIDatePicker) {
        datePickerChanged()
    }
    
    
//    NEW METHODS
    
    func datePickerChanged () {
        initialDateLabel.text = DateFormatter.localizedString(from: initialDateCalendarPicker.date, dateStyle: DateFormatter.Style.short, timeStyle: DateFormatter.Style.short)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        if indexPath.section == 0 && indexPath.row == 0 {
            toggleDatepicker()
        }
        print("OLA")
    }
    
    var datePickerHidden = false

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if datePickerHidden && indexPath.section == 0 && indexPath.row == 1 {
            return 0
        }
        else {
            //            return tableView(tableView, heightForRowAtIndexPath: indexPath)
            return super.tableView(tableView, heightForRowAt: indexPath as IndexPath)
        }
    }
    
    func toggleDatepicker() {
        
        datePickerHidden = !datePickerHidden
        print("ola")
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
    
    
//    OLD METHODS
    
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

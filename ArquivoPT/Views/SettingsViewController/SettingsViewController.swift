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
    @IBOutlet weak var finalDateLabel: UILabel!
    
    @IBOutlet weak var initialDateMainLabel: UILabel!
    @IBOutlet weak var finalDateMainLabel: UILabel!
    
    @IBOutlet weak var versionMainLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    
    @IBOutlet weak var initialDateCalendarPicker: UIDatePicker!
    @IBOutlet weak var finalDateCalendarPicker: UIDatePicker!

    
    var initialDatePickerHidden = true
    var finalDatePickerHidden = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ThemeFunctions.applyTheme(view: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyy HH:mm"
        let minDate = formatter.date(from: "01/01/1996 00:00")
        let maxDate = Date()
        let loc = Locale(identifier: "pt")
        self.initialDateCalendarPicker.locale = loc
        self.finalDateCalendarPicker.locale = loc
        
        //Set colors
        initialDateLabel.textColor = Theme.current.textColor
        finalDateLabel.textColor = Theme.current.textColor
        
        themeLable.textColor = Theme.current.textColor
        timeIntervalLabel.textColor = Theme.current.textColor
        
        initialDateMainLabel.textColor = Theme.current.textColor
        finalDateMainLabel.textColor = Theme.current.textColor
        
        versionMainLabel.textColor = Theme.current.textColor
        versionLabel.textColor = Theme.current.textColor
        
        //Load data in memory
        if let themeMode = UserDefaults.standard.value(forKey: GlobalKeys.themeKey){
            themeSwitch.isOn = themeMode as! Bool
        }
        
        if let filterDay = UserDefaults.standard.value(forKey: GlobalKeys.dayFilterKey){
            timeIntervalSwitch.isOn = filterDay as! Bool
        }
        
        if let initialFilter = UserDefaults.standard.value(forKey: GlobalKeys.initialFilterDateKey){
            if let finalFilter = UserDefaults.standard.value(forKey: GlobalKeys.finalFilterDateKey){
                SettingsParams.initialFilterDate = initialFilter as! Date
                SettingsParams.finalFilterDate = finalFilter as! Date
                
                setUpFinalPicker(minDate: SettingsParams.initialFilterDate, maxDate: maxDate, currentDate: SettingsParams.finalFilterDate)
                setUpInitialPicker(minDate: minDate!, maxDate: SettingsParams.finalFilterDate, currentDate: SettingsParams.initialFilterDate)
            }
        }else{
            setUpInitialPicker(minDate: minDate!, maxDate: maxDate, currentDate: minDate!)
            setUpFinalPicker(minDate: minDate!, maxDate: maxDate, currentDate: maxDate)
        }
    }
    

    //    ====================================================================
    //    --------------------------- METHODS --------------------------------
    //    ====================================================================
    
    @IBAction func themeChange(_ sender: UISwitch) {
        Theme.current = sender.isOn ? DarkTheme() : LightTheme()
        UserDefaults.standard.set(sender.isOn, forKey: GlobalKeys.themeKey)
        ThemeFunctions.applyTheme(view: view)
        navigationController?.navigationBar.barTintColor = Theme.current.navigationBackground
        
        //Change colors
        themeLable.textColor = Theme.current.textColor
        timeIntervalLabel.textColor = Theme.current.textColor
        
        if initialDatePickerHidden {
            initialDateLabel.textColor = Theme.current.textColor
        }
        if finalDatePickerHidden{
           finalDateLabel.textColor = Theme.current.textColor
        }
        
        initialDateMainLabel.textColor = Theme.current.textColor
        finalDateMainLabel.textColor = Theme.current.textColor
        
        versionMainLabel.textColor = Theme.current.textColor
        versionLabel.textColor = Theme.current.textColor
        
        initialDateCalendarPicker.setValue(Theme.current.textColor, forKeyPath: "textColor")
        finalDateCalendarPicker.setValue(Theme.current.textColor, forKeyPath: "textColor")
    
    }

    
    @IBAction func timeIntervalSetChange(_ sender: UISwitch) {
        if sender.isOn {
            SettingsParams.filterDateHiddden = !SettingsParams.filterDateHiddden
            tableView.beginUpdates()
            tableView.endUpdates()
        } else {
            SettingsParams.filterDateHiddden = !SettingsParams.filterDateHiddden
            initialDatePickerHidden = true
            initialDateLabel.textColor = Theme.current.textColor
            finalDatePickerHidden = true
            finalDateLabel.textColor = Theme.current.textColor
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        UserDefaults.standard.set(sender.isOn, forKey: GlobalKeys.dayFilterKey)
    }
    
    @IBAction func initialPickerChanged(_ sender: UIDatePicker) {
        initialDatePickerChanged()
    }
    @IBAction func finalPickerChanged(_ sender: UIDatePicker) {
        finalDatePickerChanged()
    }
    
    func initialDatePickerChanged () {
        initialDateLabel.text = DateFormatter.localizedString(from: initialDateCalendarPicker.date, dateStyle: DateFormatter.Style.short, timeStyle: DateFormatter.Style.none)
        SettingsParams.initialFilterDate = initialDateCalendarPicker.date
        UserDefaults.standard.set(SettingsParams.initialFilterDate, forKey: GlobalKeys.initialFilterDateKey)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyy"
        let minDateTime = formatter.date(from: initialDateLabel.text!)
        finalDateCalendarPicker?.minimumDate = minDateTime
    }
    
    func finalDatePickerChanged () {
        finalDateLabel.text = DateFormatter.localizedString(from: finalDateCalendarPicker.date, dateStyle: DateFormatter.Style.short, timeStyle: DateFormatter.Style.none)
        SettingsParams.finalFilterDate = finalDateCalendarPicker.date
        UserDefaults.standard.set(SettingsParams.finalFilterDate, forKey: GlobalKeys.finalFilterDateKey)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyy"
        let maxDateTime = formatter.date(from: finalDateLabel.text!)
        initialDateCalendarPicker?.maximumDate = maxDateTime
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 && indexPath.row == 2 {
            toggleInitialDatepicker()
            if initialDateLabel.textColor == Theme.current.textColor{
                initialDateLabel.textColor = .red
            } else{
                initialDateLabel.textColor = Theme.current.textColor
            }
            finalDateLabel.textColor = Theme.current.textColor
        }
        if indexPath.section == 1 && indexPath.row == 4 {
            toggleFinalDatepicker()
            if finalDateLabel.textColor == Theme.current.textColor{
                finalDateLabel.textColor = .red
            } else{
                finalDateLabel.textColor = Theme.current.textColor
            }
            initialDateLabel.textColor = Theme.current.textColor
        }
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if SettingsParams.filterDateHiddden && indexPath.section == 1 && indexPath.row == 2{
            return 0
        } else if SettingsParams.filterDateHiddden && indexPath.section == 1 && indexPath.row == 4{
            return 0
        } else if indexPath.section == 1 && indexPath.row == 1 {
            return 0
        } else if initialDatePickerHidden && indexPath.section == 1 && indexPath.row == 3 {
            return 0
        } else if finalDatePickerHidden && indexPath.section == 1 && indexPath.row == 5{
            return 0
        } else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    func toggleInitialDatepicker() {
        initialDatePickerHidden = !initialDatePickerHidden
        if finalDatePickerHidden == false {
            finalDatePickerHidden = true
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func toggleFinalDatepicker() {
        finalDatePickerHidden = !finalDatePickerHidden
        if initialDatePickerHidden == false {
            initialDatePickerHidden = true
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func setUpInitialPicker(minDate: Date, maxDate: Date, currentDate: Date){
        
        initialDateLabel.text = DateFormatter.localizedString(from: currentDate, dateStyle: DateFormatter.Style.short, timeStyle: DateFormatter.Style.none)
        
        initialDateCalendarPicker?.datePickerMode = .date
        initialDateCalendarPicker.date = currentDate
        
        initialDateCalendarPicker?.maximumDate = maxDate
        initialDateCalendarPicker?.minimumDate = minDate
        
        initialDateCalendarPicker.setValue(false, forKeyPath: "highlightsToday")
        initialDateCalendarPicker.setValue(Theme.current.textColor, forKeyPath: "textColor")
        
        
    }
    
    func setUpFinalPicker(minDate: Date, maxDate: Date, currentDate: Date){
        
        finalDateLabel.text = DateFormatter.localizedString(from: currentDate, dateStyle: DateFormatter.Style.short, timeStyle: DateFormatter.Style.none)
        
        finalDateCalendarPicker?.datePickerMode = .date
        finalDateCalendarPicker.date = currentDate
        
        finalDateCalendarPicker?.maximumDate = maxDate
        finalDateCalendarPicker?.minimumDate = minDate
        
        finalDateCalendarPicker.setValue(false, forKeyPath: "highlightsToday")
        finalDateCalendarPicker.setValue(Theme.current.textColor, forKeyPath: "textColor")
    }
    
    
}

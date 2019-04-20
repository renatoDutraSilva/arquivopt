//
//  PopupViewController.swift
//  ArquivoPT
//
//  Created by Paulo Rocha on 13/04/2019.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {

    @IBOutlet weak var popupTitleLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var datePicker: UIPickerView!
    
    var validDates = [String]()
    var selectedDate: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        datePicker.delegate = self
        datePicker.selectRow(selectedDate!, inComponent:0, animated:true)
    }
    @IBAction func closeButtonTaped(_ sender: UIButton) {
        NotificationCenter.default.post(name: .saveSelectedDate, object: self)
        dismiss(animated: true)
    }
    
}

extension PopupViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return validDates.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return validDates[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedDate = row
    }
}

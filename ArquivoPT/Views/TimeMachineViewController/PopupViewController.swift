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
    @IBOutlet weak var pickerDate: UIDatePicker!
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func closeButtonTaped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}

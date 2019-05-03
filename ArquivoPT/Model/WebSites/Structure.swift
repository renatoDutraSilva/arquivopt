//
//  Structure.swift
//  ArquivoPT
//
//  Created by Paulo Rocha on 07/04/2019.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import Foundation

class Structure {
    var websiteName = [String]()
    var websiteFileId = [String]()
    
    init(websiteName: [String], websiteFileId: [String]) {
        self.websiteName = websiteName
        self.websiteFileId = websiteFileId
        
    }
}

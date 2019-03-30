//
//  Site.swift
//  ArquivoPT
//
//  Created by Renato Silva on 3/27/19.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import Foundation

class Site {
    
    let siteLogo: String // URL Data?
    let siteName: String
    let versions: [(String,String)]?
    let category: Category
    
    init(siteLogo: String, siteName: String, versions: [(String,String)]?, category: Category ){
        
        self.siteLogo = siteLogo
        self.siteName = siteName
        self.versions = versions ?? [("0","0")]
        self.category = category
        
        // Inittializer definition
        // Which Branch!?????
    }
    
}

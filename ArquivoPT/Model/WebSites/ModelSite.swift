//
//  Site.swift
//  ArquivoPT
//
//  Created by Renato Silva on 3/27/19.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import Foundation

class ModelSite {
    
    let id: UUID
    let cardImage: String
    let siteLogo: String // URL Data?
    let siteName: String
    let versions: [(String,String)]?
    let category: Category
    var isFavorite: Bool = false
    
    var linkData: [String]
    
    static func placeHolder() -> ModelSite {
        return ModelSite(cardImage: "N/A", siteLogo: "default.png", siteName: "Default", versions: nil, category: Category.semCategoria, linkData: ["N/A"])
    }
    
    init(cardImage: String, siteLogo: String, siteName: String, versions: [(String,String)]?, category: Category, linkData: [String]){
        
        id = UUID()
        self.cardImage = cardImage
        self.siteLogo = siteLogo
        self.siteName = siteName
        self.versions = versions ?? [("0","0")]
        self.category = category
        
        self.linkData = linkData
    }
    
}

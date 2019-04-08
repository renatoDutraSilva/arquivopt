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

    let siteLogo: String // URL Data?
    let siteName: String
    let siteFileId: String
    let versions: [(String,String)]?
    let category: Category
    var isFavorite: Bool = false
    
    var linkData: [String]
    var linkDataID: [String]
    
    static func placeHolder() -> ModelSite {
        return ModelSite(siteLogo: "default.png", siteName: "Default", siteFileId: "default", versions: nil, category: Category.semCategoria, linkData: ["N/A"], linkDataID: ["N/A"])
    }
    
    init(siteLogo: String, siteName: String, siteFileId: String, versions: [(String,String)]?, category: Category, linkData: [String], linkDataID: [String]){
        
        id = UUID()

        self.siteLogo = siteLogo
        self.siteName = siteName
        self.siteFileId = siteFileId
        self.versions = versions ?? [("0","0")]
        self.category = category
        
        self.linkData = linkData
        self.linkDataID = linkDataID
    }
    
}

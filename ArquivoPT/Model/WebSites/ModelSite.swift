//
//  Site.swift
//  ArquivoPT
//
//  Created by Renato Silva on 3/27/19.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import Foundation

class ModelSite{
    
    
    let id: UUID

    let siteLogo: String // URL Data?
    let siteName: String
    let siteFileId: String
    let category: Category
    let totalRecords: Int
    let firstRecordedYear: String
    let lastRecordedYear: String
    var isFavorite: Bool

    var linkData: [String]
    var linkDataID: [String]
    
    static func placeHolder() -> ModelSite {
        return ModelSite(siteLogo: "default.png", siteName: "Default", siteFileId: "default", category: Category.semCategoria, linkData: ["N/A"], linkDataID: ["N/A"], totalRecords: 0, firstRecordedYear: "N/A", lastRecordedYear: "N/A", isFavorite: false)
    }
    
    init(siteLogo: String, siteName: String, siteFileId: String, category: Category, linkData: [String], linkDataID: [String], totalRecords: Int, firstRecordedYear: String, lastRecordedYear: String, isFavorite: Bool){
        
        id = UUID()

        self.siteLogo = siteLogo
        self.siteName = siteName
        self.siteFileId = siteFileId
        self.category = category
        
        self.linkData = linkData
        self.linkDataID = linkDataID
        self.totalRecords = totalRecords
        self.firstRecordedYear = firstRecordedYear
        self.lastRecordedYear = lastRecordedYear
        self.isFavorite = isFavorite
    }
    
}

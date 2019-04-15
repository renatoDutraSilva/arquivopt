//
//  SiteFunctions.swift
//  ArquivoPT
//
//  Created by Paulo Rocha on 30/03/2019.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import Foundation
import UIKit

class SiteFunctions {
    
    static func createSite(site: ModelSite){
        
    }
    
    static func readSites(completion: @escaping (_ filteredData: [Category: [ModelSite]]) -> () ){
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            generateStructure()
            initiateMainSiteArray()

            for i in 0 ... Category.allCases.count - 1{
                if let temp = GlobalData.structureSiteArray[Category.getRawValueFromIndex(index: i)]{
                    let numberOfSites = temp[0].websiteName.count
                    
                    for j in 0 ... numberOfSites - 1{
                        let nameOfLogo = temp[0].websiteFileId[j] + ".png"
                        let nameOfSite = temp[0].websiteName[j]
                        let fileId = temp[0].websiteFileId[j]
                        let category = Category.getRawValueFromIndex(index: i)
                        let linkData = loadLinks(fileName: temp[0].websiteFileId[j] + "_Links")
                        let linkDataID = loadLinks(fileName: temp[0].websiteFileId[j] + "_LinksID")
                        
                        GlobalData.mainSiteArray[Category.getRawValueFromIndex(index: i)]?.append(
                            ModelSite(siteLogo: nameOfLogo,
                                      siteName: nameOfSite,
                                      siteFileId: fileId,
                                      category: category,
                                      linkData: linkData,
                                      linkDataID: linkDataID))
                    }
                }
            }
            
            let filteredData = GlobalData.mainSiteArray
            DispatchQueue.main.async {
                completion(filteredData)
            }
        }
    }
    
    static func readSite(by id: UUID, category: Category, completion: @escaping (ModelSite?) -> ()){
        DispatchQueue.global(qos: .userInteractive).async {
            let site = GlobalData.mainSiteArray[category]?.first(where: {$0.id == id})
            
            DispatchQueue.main.async {
                completion(site)
            }
        }
    }
    
    static func updateSite(site: ModelSite){
        
    }
    
    static func deleteSite(site: ModelSite){
        
    }
    
    static func loadLinks(fileName: String) -> [String]{
        var result = [String]()
        if let asset = NSDataAsset(name: fileName),
            let string = String(data:asset.data, encoding: String.Encoding.utf8){
            result = string.components(separatedBy: ",")
        }
        return result
    }
    
    static func generateStructure(){
        GlobalData.structureSiteArray = [
            .jornais: [Structure(websiteName:
                ["Diário de Notícias", "Público", "Jornal de Notícias", "Correio da Manhã", "Sol", "Destak"],
                                 websiteFileId:
                ["dn", "publico", "jn", "cm", "sol", "destak"])],
            .artesECultura: [Structure(websiteName:
                ["Gulbenkian"],
                                  websiteFileId:
                ["gulbenkian"])],
            .desporto: [Structure(websiteName:
                ["A Bola"],
                                  websiteFileId:
                ["bola"])],
            .radioETV: [Structure(websiteName:
                ["SIC", "TVI", "RTP"],
                                  websiteFileId:
                ["sic", "tvi", "rtp"])],
            .organismosSociais: [Structure(websiteName:
                ["FCT"],
                                           websiteFileId:
                ["fct"])],
            .organismosGovernamentais: [Structure(websiteName:
                ["Presidencia"],
                                                  websiteFileId:
                ["presidencia"])],
            .universidades: [Structure(websiteName:
                ["Universidade de Lisboa"],
                                       websiteFileId:
                ["ul"])],
            .eventos: [Structure(websiteName:
                ["Expo 98"],
                                 websiteFileId:
                ["expo98"])],
            .personalidades: [Structure(websiteName:
                ["Fundação José Saramago"],
                                        websiteFileId:
                ["josesaramago"])]
        ]
    }
    
    static func initiateMainSiteArray(){
        GlobalData.mainSiteArray = [
            .jornais: [],
            .artesECultura: [],
            .desporto: [],
            .radioETV: [],
            .organismosSociais: [],
            .organismosGovernamentais: [],
            .universidades: [],
            .eventos: [],
            .personalidades: []
        ]
    }
    
}

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
            
            if let favoriteIdArray = UserDefaults.standard.value(forKey: GlobalKeys.favoriteKey){
                GlobalData.favoriteID = favoriteIdArray as! [String]
            }
            

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
                        let totalRecords = linkData.count
                        let firstRecordedYear = String(linkDataID[linkDataID.count - 2].prefix(4))
                        let lastRecordedYear = String(linkDataID[0].prefix(4))
                        var isFavorite = false
                        if GlobalData.favoriteID.contains(fileId){
                            isFavorite = true
                        }
                        
                        GlobalData.mainSiteArray[Category.getRawValueFromIndex(index: i)]?.append(
                            ModelSite(siteLogo: nameOfLogo,
                                      siteName: nameOfSite,
                                      siteFileId: fileId,
                                      category: category,
                                      linkData: linkData,
                                      linkDataID: linkDataID,
                                      totalRecords: totalRecords,
                                      firstRecordedYear: firstRecordedYear,
                                      lastRecordedYear: lastRecordedYear,
                                      isFavorite: isFavorite))
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
            .artesECultura: [Structure(websiteName:
                ["Instituto Camões", "Património Cultural", "Casa da Música", "Centro Cultural de Belém"],
                                  websiteFileId:
                ["institutocamoes", "patrimoniocultural", "casadamusica", "ccb"])],
            .bibliotecasEArquivos: [ Structure(websiteName:
                ["Biblioteca Nacional", "Torre do Tombo", "iGEO"],
                                                websiteFileId:
                ["bn", "tombo", "igeo"])],
            .fundacoes: [Structure(websiteName:
                ["Fundação C. Gulbenkian", "FCT", "Fundação J. Saramago", "Culturgest"],
                                           websiteFileId:
                ["gulbenkian", "fct", "fundsaramago", "culturgest"])],
            .organismosGovernamentais: [Structure(websiteName:
                ["Presidencia"],
                                                  websiteFileId:
                ["presidencia"])],
            .universidades: [Structure(websiteName:
                ["Uni. de Lisboa", "Uni. Nova de Lisboa", "IST", "Uni. Lusófona", "ISEG"],
                                       websiteFileId:
                ["ul", "universidadenova", "ist", "lusofona", "iseg"])],
            .eventos: [Structure(websiteName:
                ["Expo 98", "Euro 2004"],
                                 websiteFileId:
                ["expo98", "euro2004"])],
            .personalidades: [Structure(websiteName:
                ["José Saramago"],
                                        websiteFileId:
                ["saramago"])]
        ]
    }
    
    static func initiateMainSiteArray(){
        GlobalData.mainSiteArray = [
            .artesECultura: [],
            .bibliotecasEArquivos: [],
            .fundacoes: [],
            .organismosGovernamentais: [],
            .universidades: [],
            .eventos: [],
            .personalidades: []
        ]
    }
    
}

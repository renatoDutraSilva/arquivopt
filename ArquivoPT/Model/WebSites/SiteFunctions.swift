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

//            GlobalData.mainSiteArray = [
//                .jornais: [
//                    ModelSite(siteLogo: "dn.png", siteName: "Diário de Notícias", versions: nil, category: .jornais, linkData: linkData),
//                    ModelSite(siteLogo: "publico.png", siteName: "Público", versions: nil, category: .jornais, linkData: linkData),
//                    ModelSite(siteLogo: "jn.png", siteName: "Jornal de Notícias", versions: nil, category: .jornais, linkData: linkData),
//                    ModelSite(siteLogo: "dnoticias.png", siteName: "Correio da Manhã", versions: nil, category: .jornais, linkData: linkData),
//                    ModelSite(siteLogo: "dn.Logo", siteName: "Sol", versions: nil, category: .jornais, linkData: linkData),
//                    ModelSite(siteLogo: "dn.Logo", siteName: "Destak", versions: nil, category: .jornais, linkData: linkData)
//                ],
//
//                .artesECultura: [
//                    ModelSite(siteLogo: "gulbenkian.png", siteName: "Gulbenkian", versions: nil, category: .artesECultura, linkData: linkData)
//                ],
//                .desporto: [
//                    ModelSite(siteLogo: "dn.Logo", siteName: "A Bola", versions: nil, category: .desporto, linkData: linkData)
//                ],
//                .radioETV: [
//                    ModelSite(siteLogo: "sic.png", siteName: "SIC", versions: nil, category: .radioETV, linkData: linkData),
//                    ModelSite(siteLogo: "tvi.png", siteName: "TVI", versions: nil, category: .radioETV, linkData: linkData),
//                    ModelSite(siteLogo: "rtp.png", siteName: "RTP", versions: nil, category: .radioETV, linkData: linkData)
//
//                ],
//                .organismosSociais: [
//                    ModelSite(siteLogo: "dn.Logo", siteName: "FCT", versions: nil, category: .organismosSociais, linkData: linkData)
//                ],
//                .organismosGovernamentais: [
//                    ModelSite(siteLogo: "presidencia.png", siteName: "Presidencia", versions: nil, category: .organismosGovernamentais, linkData: linkData)
//                ],
//                .universidades: [
//                    ModelSite(siteLogo: "dn.Logo", siteName: "Universidade de Lisboa", versions: nil, category: .universidades, linkData: linkData)
//                ],
//                .eventos: [
//                    ModelSite(siteLogo: "dn.Logo", siteName: "Expo 98", versions: nil, category: .eventos, linkData: linkData)
//                ],
//                .personalidades: [
//                    ModelSite(siteLogo: "dn.Logo", siteName: "José Saramago", versions: nil, category: .personalidades, linkData: linkData)
//                ]
//            ]
            
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
                ["José Saramago"],
                                        websiteFileId:
                ["saramago"])]
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

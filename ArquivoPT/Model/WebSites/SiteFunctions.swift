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
            
            let linkData = loadLinks(fileName: "Expo98_Links")
            
            GlobalData.mainSiteArray = [
                .jornais: [
                    ModelSite(cardImage: "siteCardBackground.png", siteLogo: "dn.png", siteName: "Diário de Notícias", versions: nil, category: .jornais, linkData: linkData),
                    ModelSite(cardImage: "siteCardBackground.png", siteLogo: "publico.png", siteName: "Público", versions: nil, category: .jornais, linkData: linkData),
                    ModelSite(cardImage: "siteCardBackground.png", siteLogo: "jn.png", siteName: "Jornal de Notícias", versions: nil, category: .jornais, linkData: linkData),
                    ModelSite(cardImage: "siteCardBackground.png", siteLogo: "dnoticias.png", siteName: "Correio da Manhã", versions: nil, category: .jornais, linkData: linkData),
                    ModelSite(cardImage: "siteCardBackground.png", siteLogo: "dn.Logo", siteName: "Sol", versions: nil, category: .jornais, linkData: linkData),
                    ModelSite(cardImage: "siteCardBackground.png", siteLogo: "dn.Logo", siteName: "Destak", versions: nil, category: .jornais, linkData: linkData)
                ],
            
                .artesECultura: [
                    ModelSite(cardImage: "siteCardBackground.png", siteLogo: "gulbenkian.png", siteName: "Gulbenkian", versions: nil, category: .artesECultura, linkData: linkData)
                ],
                .desporto: [
                    ModelSite(cardImage: "siteCardBackground.png", siteLogo: "dn.Logo", siteName: "A Bola", versions: nil, category: .desporto, linkData: linkData)
                ],
                .radioETV: [
                    ModelSite(cardImage: "siteCardBackground.png", siteLogo: "sic.png", siteName: "SIC", versions: nil, category: .radioETV, linkData: linkData),
                    ModelSite(cardImage: "siteCardBackground.png", siteLogo: "tvi.png", siteName: "TVI", versions: nil, category: .radioETV, linkData: linkData),
                    ModelSite(cardImage: "siteCardBackground.png", siteLogo: "rtp.png", siteName: "RTP", versions: nil, category: .radioETV, linkData: linkData)

                ],
                .organismosSociais: [
                    ModelSite(cardImage: "siteCardBackground.png", siteLogo: "dn.Logo", siteName: "FCT", versions: nil, category: .organismosSociais, linkData: linkData)
                ],
                .organismosGovernamentais: [
                    ModelSite(cardImage: "siteCardBackground.png", siteLogo: "presidencia.png", siteName: "Presidencia", versions: nil, category: .organismosGovernamentais, linkData: linkData)
                ],
                .universidades: [
                    ModelSite(cardImage: "siteCardBackground.png", siteLogo: "dn.Logo", siteName: "Universidade de Lisboa", versions: nil, category: .universidades, linkData: linkData)
                ],
                .eventos: [
                    ModelSite(cardImage: "siteCardBackground.png", siteLogo: "dn.Logo", siteName: "Expo 98", versions: nil, category: .eventos, linkData: linkData)
                ],
                .personalidades: [
                    ModelSite(cardImage: "siteCardBackground.png", siteLogo: "dn.Logo", siteName: "José Saramago", versions: nil, category: .personalidades, linkData: linkData)
                ]
            ]
            
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
}

//
//  SiteFunctions.swift
//  ArquivoPT
//
//  Created by Paulo Rocha on 30/03/2019.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import Foundation

class SiteFunctions {
    
    static func createSite(site: ModelSite){
        
    }
    
    static func readSites(completion: @escaping () -> () ){
        
        DispatchQueue.global(qos: .userInteractive).async {
            Data.mainSiteArray = [
                .jornais: [
                    ModelSite(cardImage: "siteCardBackground.png", siteLogo: "dn.Logo", siteName: "Diário de Notícias", versions: nil, category: .jornais),
                    ModelSite(cardImage: "siteCardBackground.png", siteLogo: "dn.Logo", siteName: "Público", versions: nil, category: .jornais),
                    ModelSite(cardImage: "siteCardBackground.png", siteLogo: "dn.Logo", siteName: "Correio da Manhã", versions: nil, category: .jornais),
                    ModelSite(cardImage: "siteCardBackground.png", siteLogo: "dn.Logo", siteName: "Sol", versions: nil, category: .jornais),
                    ModelSite(cardImage: "siteCardBackground.png", siteLogo: "dn.Logo", siteName: "Destak", versions: nil, category: .jornais),
                    ModelSite(cardImage: "siteCardBackground.png", siteLogo: "dn.Logo", siteName: "DN", versions: nil, category: .jornais)
                ],
            
                .artesECultura: [
                    ModelSite(cardImage: "siteCardBackground.png", siteLogo: "dn.Logo", siteName: "Gulbenkian", versions: nil, category: .artesECultura)
                ],
                .desporto: [
                    ModelSite(cardImage: "siteCardBackground.png", siteLogo: "dn.Logo", siteName: "A Bola", versions: nil, category: .desporto)
                ],
                .radioETV: [
                    ModelSite(cardImage: "siteCardBackground.png", siteLogo: "dn.Logo", siteName: "SIC", versions: nil, category: .radioETV)
                ],
                .organismosSociais: [
                    ModelSite(cardImage: "siteCardBackground.png", siteLogo: "dn.Logo", siteName: "FCT", versions: nil, category: .organismosSociais)
                ],
                .organismosGovernamentais: [
                    ModelSite(cardImage: "siteCardBackground.png", siteLogo: "dn.Logo", siteName: "Presidencia", versions: nil, category: .organismosGovernamentais)
                ],
                .universidades: [
                    ModelSite(cardImage: "siteCardBackground.png", siteLogo: "dn.Logo", siteName: "Universidade de Lisboa", versions: nil, category: .universidades)
                ],
                .eventos: [
                    ModelSite(cardImage: "siteCardBackground.png", siteLogo: "dn.Logo", siteName: "Expo 98", versions: nil, category: .eventos)
                ],
                .personalidades: [
                    ModelSite(cardImage: "siteCardBackground.png", siteLogo: "dn.Logo", siteName: "José Saramago", versions: nil, category: .personalidades)
                ]
                
            ]
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    static func readSite(by id: UUID, category: Category, completion: @escaping (ModelSite?) -> ()){
        DispatchQueue.global(qos: .userInteractive).async {
            let site = Data.mainSiteArray[category]?.first(where: {$0.id == id})
            
            DispatchQueue.main.async {
                completion(site)
            }
        }
    }
    
    static func updateSite(site: ModelSite){
        
    }
    
    static func deleteSite(site: ModelSite){
        
    }
}

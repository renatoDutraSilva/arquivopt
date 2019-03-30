//
//  SiteFunctions.swift
//  ArquivoPT
//
//  Created by Paulo Rocha on 30/03/2019.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import Foundation

class SiteFunctions {
    
    static func createSite(site: Site){
        
    }
    
    static func readSite(completion: @escaping () -> () ){
        
        DispatchQueue.global(qos: .userInteractive).async {
            Data.mainSiteArray = [
                .jornais: [
                    Site(cardImage: "siteCardBackground.png", siteLogo: "dn.Logo", siteName: "Diário de Notícias", versions: nil, category: .jornais),
                    Site(cardImage: "siteCardBackground.png", siteLogo: "dn.Logo", siteName: "Público", versions: nil, category: .jornais),
                    Site(cardImage: "siteCardBackground.png", siteLogo: "dn.Logo", siteName: "Correio da Manhã", versions: nil, category: .jornais)
                ],
            
                .artesECultura: [
                    Site(cardImage: "siteCardBackground.png", siteLogo: "dn.Logo", siteName: "Gulbenkian", versions: nil, category: .artesECultura)
                ],
                .desporto: [
                    Site(cardImage: "siteCardBackground.png", siteLogo: "dn.Logo", siteName: "A Bola", versions: nil, category: .desporto)
                ],
                .radioETV: [
                    Site(cardImage: "siteCardBackground.png", siteLogo: "dn.Logo", siteName: "SIC", versions: nil, category: .radioETV)
                ],
                .organismosSociais: [
                    Site(cardImage: "siteCardBackground.png", siteLogo: "dn.Logo", siteName: "FCT", versions: nil, category: .organismosSociais)
                ]
            ]
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    static func updateSite(site: Site){
        
    }
    
    static func deleteSite(site: Site){
        
    }
}

//
//  Category.swift
//  ArquivoPT
//
//  Created by Renato Silva on 3/27/19.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import Foundation

enum Category: String, CaseIterable {
    
    case desporto = "Desporto"
    case artesECultura = "Artes e Cultura"
    case organismosSociais = "Organismos Sociais"
    case jornais = "Jornais e Notícias"
    case radioETV = "Rádio e Televisão"
    case organismosGovernamentais = "Organismos Governamentais"
    case universidades = "Universidades"
    case eventos = "Eventos e Exposições"
    case personalidades = "Personalidades"
    case semCategoria = "Sem Categoria"
    
   
    static func getRawValueFromIndex(index: Int) -> Category {
        switch index {
            case 0: return .desporto
            case 1: return .artesECultura
            case 2: return .organismosSociais
            case 3: return .jornais
            case 4: return .radioETV
            case 5: return .organismosGovernamentais
            case 6: return .universidades
            case 7: return .eventos
            case 8: return .personalidades
            default: return .semCategoria
        }
    }
    
    static func total() -> Int{ // Total number of categories
        return 8
    }
    
}

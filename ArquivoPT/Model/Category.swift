//
//  Category.swift
//  ArquivoPT
//
//  Created by Renato Silva on 3/27/19.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import Foundation

enum Category: String, CaseIterable {
    
    case artesECultura = "Artes e Cultura"
    case bibliotecasEArquivos = "Bibliotecas e Arquivos"
    case fundacoes = "Fundações"
    case organismosGovernamentais = "Organismos Governamentais"
    case universidades = "Universidades"
    case eventos = "Eventos e Exposições"
    case personalidades = "Personalidades"
    case semCategoria = "Sem Categoria"
    
   
    static func getRawValueFromIndex(index: Int) -> Category {
        switch index {
            case 0: return .artesECultura
            case 1: return .fundacoes
            case 2: return .organismosGovernamentais
            case 3: return .universidades
            case 4: return .eventos
            case 5: return .personalidades
            case 6: return .bibliotecasEArquivos
            default: return .semCategoria
        }
    }
    
    static func getIndexFromRawValue(rawValue: Category) -> Int {
        switch rawValue {
        case .artesECultura: return 0
        case .fundacoes: return 1
        case .organismosGovernamentais: return 2
        case .universidades: return 3
        case .eventos: return 4
        case .personalidades: return 5
        case .bibliotecasEArquivos: return 6
        default: return 0
        }
    }
}

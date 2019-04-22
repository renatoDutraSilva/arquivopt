//
//  Data.swift
//  ArquivoPT
//
//  Created by Paulo Rocha on 30/03/2019.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import Foundation


class GlobalData{
    
    static var mainSiteArray = [Category: [ModelSite]]()
    static var structureSiteArray = [Category: [Structure]]()
    static var favoriteSiteArray = [ModelSite]()
    static var favoriteID = [String]()
    
    
    static func getFavoriteCategories() -> [Category]? {
        
        var favoriteCategories = [Category]()
        
        favoriteSiteArray.forEach { (site) in
            favoriteCategories.append(site.category)
        }
        if favoriteCategories.isEmpty { return nil }
        else { return favoriteCategories.removingDuplicates() }
    }
    
    static func getFavoriteSites(ofCategory category: Category) -> [ModelSite]{
        
        var favoriteSites = [ModelSite]()
        
        favoriteSiteArray.forEach { (site) in
            if site.category == category {
                favoriteSites.append(site)
            }
        }
        return favoriteSites
    }
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

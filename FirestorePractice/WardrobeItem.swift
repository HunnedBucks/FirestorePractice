//
//  WardrobeItem.swift
//  FirestorePractice
//
//  Created by Hunter Buxton on 7/6/19.
//  Copyright © 2019 Hunter Buxton. All rights reserved.
//

import Foundation

struct WardrobeItem {
    var brand: String
    var name: String
    var id: String
    
    var dictionary: [String: Any] {
        return [
            "brand": brand,
            "name": name
        ]
    }
}

extension WardrobeItem{
    init?(dictionary: [String : Any], id: String) {
        guard   let brand = dictionary["brand"] as? String,
            let name = dictionary["name"] as? String
            else { return nil }
        
        self.init(brand: brand, name: name, id: id)
    }
}

//
//  Story.swift
//  MarvelApp.iOS
//
//  Created by Carlos Correa on 10/08/2020.
//  Copyright © 2020 marvelinc. All rights reserved.
//

import Foundation

struct Stories: Decodable {
    let available: Int
    let collectionURI: String
    let items: [Story]
    let returned: Int
    
    enum CodingKeys: String, CodingKey {
        case available
        case collectionURI
        case items
        case returned
    }
    
    init(available: Int, collectionURI: String, items: [Story], returned: Int) {
        self.available = available
        self.collectionURI = collectionURI
        self.items = items
        self.returned = returned
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let available: Int = try container.decode(Int.self, forKey: .available)
        let collectionURI: String = try container.decode(String.self, forKey: .collectionURI)
        let items: [Story] = try container.decode([Story].self, forKey: .items)
        let returned: Int = try container.decode(Int.self, forKey: .returned)

        self.init(available: available, collectionURI: collectionURI, items: items, returned: returned)
    }
    
}

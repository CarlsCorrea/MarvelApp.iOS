//
//  CharacterDataContainer.swift
//  MarvelApp.iOS
//
//  Created by Carlos Correa on 09/08/2020.
//  Copyright © 2020 marvelinc. All rights reserved.
//

import Foundation

struct CharacterDataContainer: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Character]
    
    init(offset: Int, limit: Int, total: Int, count: Int, results: [Character]) {
        self.offset = offset
        self.limit = limit
        self.total = total
        self.count = count
        self.results = results
    }
    
    enum CodingKeys: String, CodingKey {
        case offset
        case limit
        case total
        case count
        case results
    }
}

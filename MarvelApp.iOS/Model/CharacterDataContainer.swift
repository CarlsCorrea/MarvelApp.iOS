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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let offset: Int = try container.decode(Int.self, forKey: .offset)
        let limit: Int = try container.decode(Int.self, forKey: .limit)
        let total: Int = try container.decode(Int.self, forKey: .total)
        let count: Int = try container.decode(Int.self, forKey: .count)
        let results: [Character] = try container.decode([Character].self, forKey: .results)
        
        self.init(offset: offset, limit: limit, total: total, count: count, results: results)
    }
    
    enum CodingKeys: String, CodingKey {
        case offset
        case limit
        case total
        case count
        case results
    }
}

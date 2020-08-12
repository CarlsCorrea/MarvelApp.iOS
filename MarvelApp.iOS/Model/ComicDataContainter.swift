//
//  ComicDataContainter.swift
//  MarvelApp.iOS
//
//  Created by Carlos Correa on 10/08/2020.
//  Copyright © 2020 marvelinc. All rights reserved.
//

import Foundation

struct ComicDataContainter: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Comic]

    enum CodingKeys: String, CodingKey  {
        case offset
        case limit
        case total
        case count
        case results = "results"
    }

    init(offset: Int, limit: Int, total: Int, count: Int, results: [Comic]) {
        self.offset = offset
        self.limit = limit
        self.total = total
        self.count = count
        self.results = results
    }
    
}

//
//  Comic.swift
//  MarvelApp.iOS
//
//  Created by Carlos Correa on 10/08/2020.
//  Copyright © 2020 marvelinc. All rights reserved.
//

import Foundation

struct Comic: Decodable, Hashable {
    let id: Int
    let description: String?

    enum CodingKeys: String, CodingKey {
        case id
        case description
    }
    
    init(id: Int, description: String?) {
        self.id = id
        self.description = description
    }
    
}

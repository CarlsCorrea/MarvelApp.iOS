//
//  Comic.swift
//  MarvelApp.iOS
//
//  Created by Carlos Correa on 10/08/2020.
//  Copyright © 2020 marvelinc. All rights reserved.
//

import Foundation

struct ComicResource: Decodable {
    let resourceURI: String
    let name: String
    
    enum CodingKeys: String, CodingKey  {
        case resourceURI
        case name
    }
    
    init(resourceURI: String, name: String) {
        self.resourceURI = resourceURI
        self.name = name
    }
    
}

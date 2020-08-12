//
//  StoriesItem.swift
//  MarvelApp.iOS
//
//  Created by Carlos Correa on 10/08/2020.
//  Copyright © 2020 marvelinc. All rights reserved.
//

import Foundation

struct Story: Decodable {
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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let resourceURI: String = try container.decode(String.self, forKey: .resourceURI)
        let name: String = try container.decode(String.self, forKey: .name)
        
        self.init(resourceURI: resourceURI, name: name)
    }
    
}


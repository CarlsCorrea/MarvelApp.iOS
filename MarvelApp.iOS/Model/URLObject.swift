//
//  URLObject.swift
//  MarvelApp.iOS
//
//  Created by Carlos Correa on 10/08/2020.
//  Copyright © 2020 marvelinc. All rights reserved.
//

import Foundation

struct URLObject: Decodable {
    let type: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case type
        case url
    }
    
    init(type: String, url: String) {
        self.type = type
        self.url = url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type: String = try container.decode(String.self, forKey: .type)
        let url: String = try container.decode(String.self, forKey: .url)
        self.init(type: type, url: url)
    }

}

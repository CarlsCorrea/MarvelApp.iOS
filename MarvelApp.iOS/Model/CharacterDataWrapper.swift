//
//  CharacterDataWrapper.swift
//  MarvelApp.iOS
//
//  Created by Carlos Correa on 09/08/2020.
//  Copyright © 2020 marvelinc. All rights reserved.
//

import Foundation

struct CharacterDataWrapper: Decodable {
    let code: Int
    let status: String
    let data: CharacterDataContainer
    
    enum CodingKeys: String, CodingKey {
        case code
        case status
        case data
    }
    
    init(code: Int, status: String, data: CharacterDataContainer) {
        self.code = code
        self.status = status
        self.data = data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let code: Int = try container.decode(Int.self, forKey: .code)
        let status: String = try container.decode(String.self, forKey: .status)
        let data: CharacterDataContainer = try container.decode(CharacterDataContainer.self, forKey: .data)
        
        self.init(code: code, status: status, data: data)
    }
}

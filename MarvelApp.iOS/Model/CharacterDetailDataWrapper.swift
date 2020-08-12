//
//  CharacterDetailDataWrapper.swift
//  MarvelApp.iOS
//
//  Created by Carlos Correa on 10/08/2020.
//  Copyright © 2020 marvelinc. All rights reserved.
//

import Foundation

struct CharacterDetailDataWrapper: Decodable {
    let code: Int
    let status: String
    let data: CharacterDetailDataContainter
    
    enum CodingKeys: String, CodingKey {
        case code
        case status
        case data
    }
    
    init(code: Int, status: String, data: CharacterDetailDataContainter) {
        self.code = code
        self.status = status
        self.data = data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let code: Int = try container.decode(Int.self, forKey: .code)
        let status: String = try container.decode(String.self, forKey: .status)
        let data: CharacterDetailDataContainter = try container.decode(CharacterDetailDataContainter.self, forKey: .data)
        
        self.init(code: code, status: status, data: data)
    }
}

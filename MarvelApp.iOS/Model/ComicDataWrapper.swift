//
//  ComicDataWrapper.swift
//  MarvelApp.iOS
//
//  Created by Carlos Correa on 10/08/2020.
//  Copyright © 2020 marvelinc. All rights reserved.
//

import Foundation

struct ComicDataWrapper: Decodable {
    let code: Int
    let status: String
    let data: ComicDataContainter?
    
    enum CodingKeys: String, CodingKey {
        case code
        case status
        case data
    }
    
    init(code: Int, status: String, data: ComicDataContainter?) {
        self.code = code
        self.status = status
        self.data = data
    }
    
}

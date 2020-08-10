//
//  Character.swift
//  MarvelApp.iOS
//
//  Created by Carlos Correa on 09/08/2020.
//  Copyright © 2020 marvelinc. All rights reserved.
//

import Foundation

struct Character: Decodable{
    var id: Int
    var name: String
    var description: String
    var thumbnail: Thumbnail
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case thumbnail
    }
    
    init(id: Int, name: String, description: String, thumbnail: Thumbnail) {
        
        self.id = id
        self.name = name
        self.description = description
        self.thumbnail = thumbnail
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id: Int = try container.decode(Int.self, forKey: .id)
        let name: String = try container.decode(String.self, forKey: .name)
        let description: String = try container.decode(String.self, forKey: .description)
        let thumbnail: Thumbnail = try container.decode(Thumbnail.self, forKey: .thumbnail)

        self.init(id: id, name: name, description: description, thumbnail: thumbnail)
    }
}


struct Thumbnail: Decodable {
    let path: String
    let ext: String
    
    var url: String {
        return path + "." + ext
    }
    
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
        
    }
    
    init(path: String, ext: String) {
        self.path = path
        self.ext = ext
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let path: String = try container.decode(String.self, forKey: .path)
        let ext: String = try container.decode(String.self, forKey: .ext)
        
        self.init(path: path, ext: ext)
    }
    
}

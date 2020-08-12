//
//  SettingsAPI.swift
//  MarvelApp.iOS
//
//  Created by Carlos Correa on 10/08/2020.
//  Copyright © 2020 marvelinc. All rights reserved.
//

import Foundation

class SettingsAPI {
    
    public let basePath = "https://gateway.marvel.com:443/v1/public/"
    public let publicKey = "3574c5db9f35c66a7a92a436d0b481a0"
    public let privateKey = "a4af2bd95474b9c8c11dbe7a6f5a635e67522590"
    
    public func getCredentials() -> String {
        let ts = String(Date().timeIntervalSince1970)
        let hash = ts+privateKey+publicKey
        return "ts=\(ts)&apikey=\(publicKey)&hash=\(hash.md5)"
    }
}

//
//  CharactersListService.swift
//  MarvelApp.iOS
//
//  Created by Carlos Correa on 09/08/2020.
//  Copyright © 2020 marvelinc. All rights reserved.
//

import Foundation

class CharactersListService{
    
    private let basePath = "https://gateway.marvel.com:443/v1/public/"
    private let publicKey = "3574c5db9f35c66a7a92a436d0b481a0"
    private let privateKey = "a4af2bd95474b9c8c11dbe7a6f5a635e67522590"
    private let clientApi: ClientAPI
    private let itemsPerPage = 20
    var page: Int = 0
 
    init(clientApi: ClientAPI=ClientAPI()) {
        self.clientApi = clientApi
    }
    
    private func getCredentials() -> String {
        let ts = String(Date().timeIntervalSince1970)
        let hash = ts+privateKey+publicKey
        return "ts=\(ts)&apikey=\(publicKey)&hash=\(hash.md5)"
    }
    
    func getCharacters(characterName:String?, completionHandler: @escaping (CharacterDataWrapper?) -> Void) {
        
        var parameters:String=""
        if characterName != nil {
            parameters = "characters?" + "nameStartsWith=\(String(describing: characterName!))&"
        } else {
            let offset = page * itemsPerPage
            parameters = "characters?" + "offset=\(offset)&limit=\(itemsPerPage)&"
        }
        
        let url = basePath + parameters + getCredentials()
        
        clientApi.fetchData(urlString: url) { (value: CharacterDataWrapper) in
            completionHandler(value)
        }
        
    }
    
}

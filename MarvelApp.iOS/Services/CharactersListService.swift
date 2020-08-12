//
//  CharactersListService.swift
//  MarvelApp.iOS
//
//  Created by Carlos Correa on 09/08/2020.
//  Copyright © 2020 marvelinc. All rights reserved.
//

import Foundation

class CharactersListService{
    private let clientApi: ClientAPI
    private let settings: SettingsAPI
    private let itemsPerPage = 20
    var page: Int = 0

    init(clientApi: ClientAPI=ClientAPI(), settings: SettingsAPI=SettingsAPI()) {
        self.clientApi = clientApi
        self.settings = settings
    }
    
    func getCharacters(characterName:String?, completionHandler: @escaping (CharacterDataWrapper?) -> Void) {
        
        var parameters:String=""
        if characterName != nil {
            parameters = "characters?" + "nameStartsWith=\(String(describing: characterName!))&"
        } else {
            let offset = page * itemsPerPage
            parameters = "characters?" + "offset=\(offset)&limit=\(itemsPerPage)&"
        }
        
        let url = settings.basePath + parameters + settings.getCredentials()
        
        clientApi.fetchData(urlString: url) { (value: CharacterDataWrapper) in
            completionHandler(value)
        }
        
    }
    
}

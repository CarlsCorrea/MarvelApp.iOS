//
//  CharactersListViewModel.swift
//  MarvelApp.iOS
//
//  Created by Carlos Correa on 09/08/2020.
//  Copyright © 2020 marvelinc. All rights reserved.
//

import Foundation

protocol CharactersListViewModelDelegate {
    func charactersLoaded()
}

class CharactersListViewModel {
    var currentPage = 0
    var characters: [Character] = []
    var total = 0
    var loadingCharacters = false
    let service: CharactersListService
    var delegate: CharactersListViewModelDelegate?
    var filteredCharacter: [Character] = []
    
    init(service: CharactersListService = CharactersListService()) {
        self.service = service
    }

    func loadCharacters(searchCharacters: String?) {
        loadingCharacters = true
        service.page = currentPage
        service.getCharacters(characterName: searchCharacters) { (characters) in
            if let characters = characters {
                
                if searchCharacters == nil {
                    self.characters += characters.data.results
                    self.total = characters.data.total
                    self.delegate?.charactersLoaded()
                } else {
                    self.filteredCharacter = characters.data.results
                    self.total = characters.data.total
                    self.delegate?.charactersLoaded()
                }

            }
        }
        
    }
    
}

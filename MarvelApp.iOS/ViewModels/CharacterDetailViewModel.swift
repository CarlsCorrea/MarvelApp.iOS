//
//  CharacterDetailViewModel.swift
//  MarvelApp.iOS
//
//  Created by Carlos Correa on 10/08/2020.
//  Copyright © 2020 marvelinc. All rights reserved.
//

import Foundation

protocol CharacterDetailViewModelDelegate : class {
    func characterDetailLoaded()
}

class CharactersDetailViewModel {
    let service: CharacterDetailService
    weak var delegate: CharacterDetailViewModelDelegate?
    var filteredCharacter: [Character] = []
    var characterId = 0
    var character : Character?
    var result: CharacterDetail?
    var comicMemoryList = Set<Comic?>()
    
    init(service: CharacterDetailService = CharacterDetailService()) {
        self.service = service
    }
    
    func loadCharacterDetail() {
        if let characterId = character?.id {
            service.getCharacterDetail(characterId: "\(characterId)"){ (characterDetail) in
                if let characterDetail = characterDetail {
                    self.result = characterDetail.data.results.first
                    self.delegate?.characterDetailLoaded()
                }
            }
        }
        
    }
}

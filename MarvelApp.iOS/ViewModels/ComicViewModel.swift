//
//  ComicViewModel.swift
//  MarvelApp.iOS
//
//  Created by Carlos Correa on 10/08/2020.
//  Copyright © 2020 marvelinc. All rights reserved.
//

import Foundation

protocol ComicViewModelDelegate : class {
    func comicLoaded()
}

class ComicViewModel {
    let service: ComicService
    weak var delegate: ComicViewModelDelegate?
    var comicUrl = ""
    var comic: Comic?
    
    init(service: ComicService = ComicService()) {
        self.service = service
    }
    
    func loadComicInfo() {
        service.getComicInfo(urlString:comicUrl){ (comicInfo) in
            if let comicInfo = comicInfo {
                self.comic = comicInfo.data?.results.first
                self.delegate?.comicLoaded()
            }
        }
    }
    
    func loadStoryInfo() {
        service.getStoryInfo(urlString:comicUrl){ (comicInfo) in
            if let comicInfo = comicInfo {
                self.comic = comicInfo.data?.results.first
                self.delegate?.comicLoaded()
            }
        }
    }
}


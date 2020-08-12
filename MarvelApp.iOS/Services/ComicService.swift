//
//  ComicService.swift
//  MarvelApp.iOS
//
//  Created by Carlos Correa on 10/08/2020.
//  Copyright © 2020 marvelinc. All rights reserved.
//

import Foundation

class ComicService {
    private let clientApi: ClientAPI
    private let settingsApi: SettingsAPI

    init(clientApi: ClientAPI=ClientAPI(), settingsApi: SettingsAPI=SettingsAPI()) {
        self.clientApi = clientApi
        self.settingsApi = settingsApi
    }

    func getComicInfo(urlString:String, completionHandler: @escaping (ComicDataWrapper?) -> Void) {
         let url = "\(urlString)?" + settingsApi.getCredentials()
         clientApi.fetchData(urlString: url) { (value: ComicDataWrapper) in
             completionHandler(value)
         }
     }
    
    func getStoryInfo(urlString:String, completionHandler: @escaping (ComicDataWrapper?) -> Void) {
         let url = "\(urlString)?" + settingsApi.getCredentials()
         clientApi.fetchData(urlString: url) { (value: ComicDataWrapper) in
             completionHandler(value)
         }
     }
}


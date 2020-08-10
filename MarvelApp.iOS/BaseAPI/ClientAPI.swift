//
//  ClientAPI.swift
//  MarvelApp.iOS
//
//  Created by Carlos Correa on 09/08/2020.
//  Copyright © 2020 marvelinc. All rights reserved.
//

import Foundation

class ClientAPI {
    
    func fetchData<T:Decodable>(urlString: String, completion: @escaping (T)->()) {

        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                print(err)
            }
            
            guard let data = data else { return }
            do {
                let obj = try JSONDecoder().decode(T.self, from: data)
                completion(obj)
            } catch let jsonError {
                print("Falied to decode json: ", jsonError)
            }
        }.resume()
    }
    
}


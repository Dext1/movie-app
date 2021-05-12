//
//  FetchAndParse.swift
//  movie-app
//
//  Created by Danie LLL on 12.5.2021.
//

import Foundation

class FetchAndParse : ObservableObject {
    
    @Published var searchData : Array<Item>? = nil
    @Published var detailedData : ItemDetail? = nil
    
    func fetch(_ url: String, search isSearch : Bool) {
        let myURL = URL(string: url)!
        
        let task = URLSession.shared.dataTask(with: myURL) {
            (optionalData, response, error) in
            self.parse(optionalData, search: isSearch)
        }
        task.resume()
    }
    
    func parse(_ optionalData: Data?, search isSearch: Bool) {
        let jsonDecoder = JSONDecoder()
        do {
            let result = try jsonDecoder.decode(Results.self, from: optionalData!)
            
            DispatchQueue.main.async {
                if(isSearch) {
                    self.searchData = result.list
                } else {
                    self.detailedData = result.details
                    
                }
            }
        } catch let error {
            print(error)
        }
    }
}

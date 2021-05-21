//
//  FetchAndParse.swift
//  movie-app
//
//  Created by Danie LLL on 12.5.2021.
//

import Foundation

class FetchAndParse : ObservableObject {
    
    // initialize data as nil
    @Published var searchData : Array<Item>? = nil
    @Published var detailedData : ItemDetail? = nil
    
    //fetch function using URLSession, search parameter determines which type of data we want
    func fetch(_ url: String, search isSearch : Bool) {
        let myURL = URL(string: url)!
        
        let task = URLSession.shared.dataTask(with: myURL) {
            //sends fetched data to get parsed, send search parameter forward
            (optionalData, response, error) in
            self.parse(optionalData, search: isSearch)
        }
        task.resume()
    }
    
    func parse(_ optionalData: Data?, search isSearch: Bool) {
        let jsonDecoder = JSONDecoder()
        if isSearch {
            do {
                //parse from json to modelled data
                let result = try jsonDecoder.decode(Results.self, from: optionalData!)
                
                //update data in main thread
                DispatchQueue.main.async {
                    self.searchData = result.list
                }
            } catch let error {
                print(error)
            }
        } else {
            do {
                let itemDetail = try jsonDecoder.decode(ItemDetail.self, from: optionalData!)
                
                DispatchQueue.main.async {
                    self.detailedData = itemDetail
                }
            } catch let error {
                print(error)
            }
        }
    }
}

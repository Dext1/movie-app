//
//  ResponseModel.swift
//  movie-app
//
//  Created by Danie LLL on 12.5.2021.
//

import Foundation

struct Results : Decodable {
    enum CodingKeys: String, CodingKey {
        case list = "Search"
        case amountOfItems = "totalResults"
        case details = ""
       }
    let list : Array<Item>?
    let details : ItemDetail?
    let amountOfItems : String?
}
    
struct Items : Decodable {
    let item : Item?
}

struct Item : Decodable {
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbId = "imdbID"
        case poster = "Poster"
       }
    let title : String?
    let year : String?
    let imdbId : String?
    let poster : String?
}

struct ItemDetail : Decodable {
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case actors = "Actors"
        case plot = "Plot"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case metascore = "Metascore"
        case imdbRating = "imdbRating"
       }
    let title : String?
    let released : String?
    let runtime : String?
    let genre : String?
    let director : String?
    let actors : String?
    let plot : String?
    let country : String?
    let awards : String?
    let poster : String?
    let metascore : String?
    let imdbRating : String?
}

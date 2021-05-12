//
//  ContentView.swift
//  movie-app
//
//  Created by Danie LLL on 12.5.2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var fetchAndParse = FetchAndParse()
    @State var searchTerm = ""
    @State var contentType = "movie"
    
    let apiKey = "secret"
    let baseURL = "https://www.omdbapi.com/?apikey="
    
    var body: some View {
        VStack(alignment: .leading, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
            Text("Movies").fontWeight(.bold).padding()
            HStack(alignment: .center, spacing: nil, content: {
                TextField("Search for a movie", text: $searchTerm).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                Button(action: {
                    fetchAndParse.fetch("\(baseURL)\(apiKey)&s=\(searchTerm)&type=\(contentType)", search: true)
                }) {
                    Text("Search").padding()
                }
            })
            NavigationView {
                if let searchData = fetchAndParse.searchData {
                    List {
                        ForEach(searchData, id: \.imdbId) {
                            Text($0.title ?? "Couldn't fetch movie title")
                        }
                    }
                }
            }
        })
        Spacer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

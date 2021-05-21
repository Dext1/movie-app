//
//  ContentView.swift
//  movie-app
//
//  Created by Danie LLL on 12.5.2021.
//

import SwiftUI
import URLImage

struct ContentView: View {
    //passing data to other views using EnvironmentObject
    @EnvironmentObject var fetchAndParse: FetchAndParse
    
    @State var searchTerm = ""
    @State var contentType = ""
    @State var showSearch = true
    @State var selectedTab = 1
    
    let apiKey = "secret"
    let baseURL = "https://www.omdbapi.com/?apikey="
    
    var body: some View {
        //main view
        TabView(selection: $selectedTab) {
            VStack(alignment: .leading, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                //hide searchbar when in detail view
                if self.showSearch {
                    //Text("Movies").fontWeight(.bold).padding()
                    HStack(alignment: .center, spacing: nil, content: {
                        TextField("Search for a \(contentType)", text: $searchTerm).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                        Button(action: {
                            fetchAndParse.fetch("\(baseURL)\(apiKey)&s=\(searchTerm)&type=\(contentType)", search: true)
                        }) {
                            Text("Search").padding()
                        }
                    })
                    //set type of content when view appears
                    .onAppear() {
                        contentType = "movie"
                    }
                }
                NavigationView {
                    //null checking
                    if let searchData = fetchAndParse.searchData {
                        // create list of navigation links from fetched data
                        List {
                            ForEach(searchData, id: \.imdbId) { data in
                                NavigationLink(destination: DetailView().onAppear() {
                                    showSearch = false
                                    //fetches data for individual item
                                    fetchAndParse.fetch("\(baseURL)\(apiKey)&i=\(data.imdbId!)&plot=full", search: false)
                                }.onDisappear() {
                                    showSearch = true
                                }) {
                                    //single list item, uses URLImage module for image loading
                                    HStack(alignment: .center, spacing: nil, content: {
                                        URLImage(URL(string: data.poster!)!) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                        }
                                        //set URLImage option to load data immediately
                                        .environment(\.urlImageOptions, URLImageOptions(
                                            loadOptions: [.loadImmediately]
                                        ))
                                        .frame(width: 120.0)
                                        VStack(alignment: .leading, spacing: nil, content: {
                                            Text(data.title ?? "N/A")
                                            Text("(\(data.year ?? "N/A"))")
                                        })
                                    })
                                }
                            }
                        }
                        .navigationTitle("Movies")
                    }
                }
            })
            // label tab, tag keeps track of which tab user is on
            .tabItem {
                Text("Movies")
            }.tag(1)
            VStack(alignment: .leading, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                if self.showSearch {
                    HStack(alignment: .center, spacing: nil, content: {
                        TextField("Search for a \(contentType)", text: $searchTerm).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                        Button(action: {
                            fetchAndParse.fetch("\(baseURL)\(apiKey)&s=\(searchTerm)&type=\(contentType)", search: true)
                        }) {
                            Text("Search").padding()
                        }
                    })
                    .onAppear() {
                        contentType = "series"
                    }
                }
                NavigationView {
                    if let searchData = fetchAndParse.searchData {
                        List {
                            ForEach(searchData, id: \.imdbId) { data in
                                NavigationLink(destination: DetailView().onAppear() {
                                    showSearch = false
                                    fetchAndParse.fetch("\(baseURL)\(apiKey)&i=\(data.imdbId!)&plot=full", search: false)
                                }.onDisappear() {
                                    showSearch = true
                                }) {
                                    HStack(alignment: .center, spacing: nil, content: {
                                        URLImage(URL(string: data.poster!)!) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                        }
                                        .environment(\.urlImageOptions, URLImageOptions(
                                            loadOptions: [.loadImmediately]
                                        ))
                                        .frame(width: 120.0)
                                        VStack(alignment: .leading, spacing: nil, content: {
                                            Text(data.title ?? "N/A")
                                            Text("(\(data.year ?? "N/A"))")
                                        })
                                    })
                                }
                            }
                        }
                        .navigationTitle("Series")
                    }
                }
                //Spacer()
            })
            .tabItem {
                    Text("Series")
            }.tag(2)
        }
        // fetch data again when tab changes
        .onChange(of: selectedTab) { _ in
            fetchAndParse.fetch("\(baseURL)\(apiKey)&s=\(searchTerm)&type=\(contentType)", search: true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  movie_appApp.swift
//  movie-app
//
//  Created by Danie LLL on 12.5.2021.
//

import SwiftUI

@main
struct movie_appApp: App {
    // init global state object
    @StateObject private var fetchAndParse = FetchAndParse()
    var body: some Scene {
        WindowGroup {
            //create environmentObject to Contentview
            ContentView().environmentObject(fetchAndParse)
        }
    }
}

//
//  Views.swift
//  movie-app
//
//  Created by Danie LLL on 21.5.2021.
//

import SwiftUI
import URLImage

struct InfoField: View {
    var fieldText = ""
    var infoText = ""
    
    var body: some View {
        HStack(alignment: .top, spacing: .none, content: {
            Text(fieldText)
                .bold()
            Text(infoText)
        })
    }
}

struct DetailView: View {
    @EnvironmentObject var fetchAndParse: FetchAndParse
    
    var body: some View {
        //null checking
        if let detailedData = fetchAndParse.detailedData {
            //make view scrollable
            ScrollView {
                VStack(alignment: .leading, content: {
                    //movie title and poster
                    Text(detailedData.title ?? "N/A")
                        .font(.largeTitle)
                        .padding()
                        URLImage(URL(string: detailedData.poster!)!) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        .environment(\.urlImageOptions, URLImageOptions(
                            loadOptions: [.loadImmediately]
                        ))
                        //make poster take maximum width
                        .frame(width: scaledToFit() as? CGFloat)
                        .padding()
                    VStack(alignment: .leading, content: {
                        //rest of the data presented using custom view
                        InfoField(fieldText : "Director:", infoText : detailedData.director ?? "N/A")
                        InfoField(fieldText : "Actors:", infoText : detailedData.actors ?? "N/A")
                        InfoField(fieldText : "Released:", infoText : detailedData.released ?? "N/A")
                        InfoField(fieldText : "IMDB:", infoText : detailedData.imdbRating ?? "N/A")
                        Text("Plot:")
                            .bold()
                        Text(detailedData.plot ?? "N/A")
                    })
                    .padding()
                })}
            Spacer()
        } else {
            ProgressView()
        }
    }
}

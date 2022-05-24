//
//  ContentView.swift
//  GithubSwiftUI
//
//  Created by Nandan Prabhu on 26/03/22.
//

import SwiftUI
import SQLite3
import CoreData
import Combine

struct ContentView: View {
    @ObservedObject var output = ContentOutput()
    @ObservedObject var input = ContentInput()

    init(viewModel: ContentViewModel) {
        output = viewModel.transform(input: input)
    }

    var body: some View {
        NavigationView {
            List {
                if output.errorMessage.isEmpty {
                    ForEach(output.results) { result in
                        VStack(alignment: .leading) {
                            Spacer()
                            Text(result.fullName ?? "")
                            Spacer()
                        }
                    }.cornerRadius(4)
                        .background(Color.white)
                } else {
                    VStack(alignment: .center, spacing: 15) {
                        Spacer()
                        Image(systemName: "")
                        Text(output.errorMessage)
                        Spacer()
                    }
                }
            }.searchable(text: $input.searchText)
            .navigationTitle(Text("Search GitHub"))
            .navigationBarTitleDisplayMode(.inline)
        }
        .searchable(text: $input.searchText)
        .foregroundColor(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel())
    }
}

struct Title: ViewModifier {
    
    func body(content: Content) -> some View {
        
    }
    
}

//
//  SearchBar.swift
//  GithubSwiftUI
//
//  Created by Nandan Prabhu on 26/03/22.
//

import UIKit
import SwiftUI

struct SearchBar: UIViewRepresentable {

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: CGRect(x: 10, y: 10, width: UIScreen.main.bounds.width - 20, height: 40))
        searchBar.placeholder = "Type here"
        searchBar.searchTextField.font = UIFont.systemFont(ofSize: 14)
//        searchBar.delegate = context.coordinator
        return searchBar
    }

//    @objc func searchFieldEdited() {
//
//    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {

    }

//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, UISearchBarDelegate {
//        init() {
//
//        }
//    }
}

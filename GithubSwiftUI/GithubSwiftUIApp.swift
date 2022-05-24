//
//  GithubSwiftUIApp.swift
//  GithubSwiftUI
//
//  Created by Nandan Prabhu on 26/03/22.
//

import SwiftUI

@main
struct GithubSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView(viewModel: LoginViewModel())
        }
    }
}

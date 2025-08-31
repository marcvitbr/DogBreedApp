//
//  DogBreedsApp.swift
//  DogBreedsApp
//
//  Created by Marcelo Vitoria on 26/08/2025.
//

import SwiftUI
import SwiftData

@main
struct DogBreedsApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationStack {
                    BreedsListView()
                }
                .tabItem {
                    Label("Breeds", systemImage: "dog.fill")
                }

                NavigationStack {
                    BreedsSearchView()
                }
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            }
        }
    }
}

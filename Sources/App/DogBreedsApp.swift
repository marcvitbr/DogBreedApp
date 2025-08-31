//
//  DogBreedsApp.swift
//  DogBreedsApp
//
//  Created by Marcelo Vitoria on 26/08/2025.
//

import SwiftUI
import SwiftData
import ComposableArchitecture

@main
struct DogBreedsApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationStack {
                    BreedsListView(
                        store: .init(
                            initialState: BreedsList.State(),
                            reducer: { BreedsList() }
                        )
                    )
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

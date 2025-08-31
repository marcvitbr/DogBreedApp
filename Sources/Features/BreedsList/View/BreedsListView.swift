//
//  BreedsListView.swift
//  DogBreedsApp
//
//  Created by Marcelo Vitoria on 29/08/2025.
//

import SwiftUI
import ComposableArchitecture

@MainActor
struct BreedsListView: View {
    let store: StoreOf<BreedsList>

    var body: some View {
        NavigationStack {
            Text("Breeds List")
        }
        .onAppear {
            store.send(.fetchBreeds)
        }
    }
}

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

    let columns = [
        GridItem(.adaptive(minimum: 100, maximum: 150)),
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(store.breeds) {
                        BreedCellView(breed: $0)
                    }
                }
            }
        }
        .onAppear {
            store.send(.fetchBreeds)
        }
        .navigationTitle("Breeds")
    }
}

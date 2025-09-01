//
//  BreedsSearchView.swift
//  DogBreedsApp
//
//  Created by Marcelo Vitoria on 29/08/2025.
//

import SwiftUI
import ComposableArchitecture

@MainActor
struct BreedsSearchView: View {
    let store: StoreOf<BreedsSearch>

    @State var searchText: String = ""

    var body: some View {
        NavigationStack {
            List(store.breeds) { breed in
                NavigationLink {
                    BreedDetailView(breed: breed)
                } label: {
                    BreedSearchCellView(breed: breed)
                }
            }
            .navigationTitle("Search Breeds")
            .searchable(text: $searchText)
            .onSubmit(of: .search) {
                store.send(
                    .searchBreeds(searchText)
                )
            }
        }
    }
}

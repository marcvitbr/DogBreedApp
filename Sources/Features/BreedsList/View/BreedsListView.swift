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
                    ForEach(store.breeds) { breed in
                        Color.clear.overlay(
                            ZStack {
                                CachedAsyncImage(
                                    url: breed.imageResolvedURL
                                )

                                VStack {
                                    Spacer()
                                    Text(breed.name)
                                        .font(.caption)
                                        .foregroundColor(.primary)
                                        .background(Color.primary
                                            .colorInvert()
                                            .opacity(0.75))
                                }
                                .padding()
                            }
                        )
                        .frame(maxWidth: .infinity)
                        .aspectRatio(1, contentMode: .fit)
                        .clipped()
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

//
//  BreedCellView.swift
//  DogBreedsApp
//
//  Created by Marcelo Vitoria on 31/08/2025.
//

import SwiftUI

@MainActor
struct BreedGridCellView: View {
    let breed: Breed

    var body: some View {
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

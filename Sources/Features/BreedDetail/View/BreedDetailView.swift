//
//  BreedDetailView.swift
//  DogBreedsApp
//
//  Created by Marcelo Vitoria on 31/08/2025.
//

import SwiftUI

@MainActor
struct BreedDetailView: View {
    let breed: Breed

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                CachedAsyncImage(url: breed.imageResolvedURL)
                    .frame(height: 240)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .accessibilityHidden(true)
                    .aspectRatio(1, contentMode: .fit)

                VStack(alignment: .leading, spacing: 8) {
                    Text(breed.name)
                        .font(.title)
                        .bold()

                    if let group = breed.breedGroup, group.isEmpty == false {
                        LabeledContent("Group", value: group)
                    }

                    if let origin = breed.origin, origin.isEmpty == false {
                        LabeledContent("Origin", value: origin)
                    }

                    if let temperament = breed.temperament, temperament.isEmpty == false {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Temperament")
                                .font(.headline)
                            Text(temperament)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
        }
        .navigationTitle(breed.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

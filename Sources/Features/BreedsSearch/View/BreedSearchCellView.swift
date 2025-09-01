//
//  BreedSearchCellView.swift
//  DogBreedsApp
//
//  Created by Marcelo Vitoria on 31/08/2025.
//

import SwiftUI

@MainActor
struct BreedSearchCellView: View {
    let breed: Breed

    var body: some View {
        LazyHStack {
            LazyVStack {
                Text(breed.name)
                    .font(.headline)
                    .multilineTextAlignment(.leading)

                if let group = breed.breedGroup, group.isEmpty == false {
                    Text(group)
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                }
            }

            Spacer()

            if let origin = breed.origin, origin.isEmpty == false {
                Text(origin)
                    .font(.subheadline)
                    .multilineTextAlignment(.trailing)
            }
        }
    }
}

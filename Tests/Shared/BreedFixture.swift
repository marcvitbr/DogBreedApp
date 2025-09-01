//
//  BreedFixture.swift
//  DogBreedsApp
//
//  Created by Marcelo Vitoria on 31/08/2025.
//

@testable import DogBreedApp

extension Breed {
    static let anyBreed = Breed(
        id: 1,
        name: "Test Name",
        breedGroup: "Test Group",
        temperament: "Test Temperament",
        origin: "Test Origin"
    )
}

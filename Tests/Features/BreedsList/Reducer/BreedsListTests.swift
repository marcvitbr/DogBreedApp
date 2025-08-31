//
//  BreedsListTests.swift
//  DogBreedsApp
//
//  Created by Marcelo Vitoria on 29/08/2025.
//


//
//  BreedsListTests.swift
//  DogBreedsApp
//
//  Created by Marcelo Vitoria on 29/08/2025.
//

import Testing
import ComposableArchitecture
@testable import DogBreedApp

private actor CallCounter {
    private(set) var count = 0
    func increment() {
        count += 1
    }
}

@MainActor
final class BreedsListTests {
    @Test
    func basics() async {
        let callCounter = CallCounter()

        let store = TestStore(
            initialState: BreedsList.State(),
            reducer: { BreedsList() }) {
                $0.breedsClient.fetch = {
                    await callCounter.increment()
                    return [.anyBreed]
                }
            }

        await store.send(.fetchBreeds)

        await store.receive(\.receiveBreeds) {
            $0.breeds = [.anyBreed]
            $0.error = nil
        }

        let callCount = await callCounter.count
        #expect(callCount == 1)
    }
}

extension Breed {
    static let anyBreed = Breed(
        id: 1,
        name: "Test Name",
        breedGroup: "Test Group",
        temperament: "Test Temperament",
        origin: "Test Origin"
    )
}

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

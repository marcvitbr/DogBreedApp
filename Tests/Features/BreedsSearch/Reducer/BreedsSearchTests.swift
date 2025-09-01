//
//  BreedsSearchTests.swift
//  DogBreedsApp
//
//  Created by Marcelo Vitoria on 31/08/2025.
//

import Testing
import ComposableArchitecture
@testable import DogBreedApp

@MainActor
final class BreedsSearchTests {
    @Test
    func basics() async {
        let callCounter = CallCounter()

        let store = TestStore(
            initialState: BreedsSearch.State(),
            reducer: { BreedsSearch() }
        ) {
            $0.breedsClient.search = { searchTerm in
                await callCounter.increment()
                return [.anyBreed]
            }
        }

        await store.send(.searchBreeds("test"))

        await store.receive(\.receiveBreeds) {
            $0.breeds = [.anyBreed]
            $0.error = nil
        }

        let callCount = await callCounter.count
        #expect(callCount == 1)
    }
}

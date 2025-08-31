//
//  BreedsClient.swift
//  DogBreedsApp
//
//  Created by Marcelo Vitoria on 29/08/2025.
//

import ComposableArchitecture

@DependencyClient
struct BreedsClient {
    var fetch: () async throws -> [Breed]
}

extension BreedsClient: DependencyKey {
    static let liveValue = Self {
        return []
    }
}

extension BreedsClient: TestDependencyKey {
    static let testValue = Self (
        fetch: unimplemented("BreedsClient.fetch")
    )
}

extension DependencyValues {
    var breedsClient: BreedsClient {
        get { self[BreedsClient.self] }
        set { self[BreedsClient.self] = newValue }
    }
}

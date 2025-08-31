//
//  BreedsList.swift
//  DogBreedsApp
//
//  Created by Marcelo Vitoria on 29/08/2025.
//

import ComposableArchitecture

@Reducer
struct BreedsList {
    @Dependency(\.breedsClient) var breedsClient

    enum Failure: Error, Equatable {
        case network
        case decoding
        case other(String)
    }

    enum Action: Equatable {
        case fetchBreeds
        case receiveBreeds(Result<[Breed], Failure>)
    }

    @ObservableState
    struct State: Equatable {
        var breeds: [Breed] = []
        var error: Failure?
    }

    var body: some ReducerOf<BreedsList> {
        Reduce { state, action in
            switch action {
            case .fetchBreeds:
                return .run { send in
                    do {
                        let breeds = try await breedsClient.fetch()
                        await send(
                            .receiveBreeds(
                                .success(breeds)
                            )
                        )
                    } catch {
                        await send(
                            .receiveBreeds(
                                .failure(
                                    .other(error.localizedDescription)
                                )
                            )
                        )
                    }
                }
            case .receiveBreeds(let result):
                switch result {
                case .success(let breeds):
                    state.breeds = breeds
                    state.error = nil
                    return .none
                case .failure(let error):
                    state.error = error
                    return .none
                }
            }
        }
    }
}

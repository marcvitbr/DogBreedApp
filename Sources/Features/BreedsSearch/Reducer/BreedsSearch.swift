//
//  BreedsSearch.swift
//  DogBreedsApp
//
//  Created by Marcelo Vitoria on 31/08/2025.
//

import ComposableArchitecture

@Reducer
struct BreedsSearch {
    @Dependency(\.breedsClient) var breedsClient

    enum Failure: Error, Equatable {
        case error(String)
    }

    enum Action: Equatable {
        case searchBreeds(String)
        case receiveBreeds(Result<[Breed], Failure>)
    }

    @ObservableState
    struct State: Equatable {
        var breeds: [Breed] = []
        var error: Failure?
    }

    var body: some ReducerOf<BreedsSearch> {
        Reduce { state, action in
            switch action {
            case .searchBreeds(let term):
                return .run { send in
                    do {
                        let breeds = try await breedsClient.search(term)
                        await send(
                            .receiveBreeds(
                                .success(breeds)
                            )
                        )
                    } catch {
                        await send(
                            .receiveBreeds(
                                .failure(
                                    .error(error.localizedDescription)
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

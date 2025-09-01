//
//  BreedsClient.swift
//  DogBreedsApp
//
//  Created by Marcelo Vitoria on 29/08/2025.
//

import ComposableArchitecture
import Foundation

@DependencyClient
struct BreedsClient {
    var fetch: () async throws -> [Breed]
    var search: (String) async throws -> [Breed]
}

enum BreedsClientError: Error {
    case invalidURL
    case missingAPIKey
    case transportError(underlying: String)
    case networkError(statusCode: Int)
    case decodingError
    case unimplemented
}

extension BreedsClient: DependencyKey {
    static let liveValue = BreedsClient(
        fetch: fetch,
        search: search
    )

    static let fetch: () async throws -> [Breed] = {
        guard let url = URL(string: "https://api.thedogapi.com/v1/breeds") else {
            throw BreedsClientError.invalidURL
        }

        return try await getBreeds(url)
    }

    static let search: (String) async throws -> [Breed] = { searchTerm in
        guard let url = URL(string: "https://api.thedogapi.com/v1/breeds/search?q=\(searchTerm)") else {
            throw BreedsClientError.invalidURL
        }

        return try await getBreeds(url)
    }

    private static let getBreeds: (_ url: URL) async throws -> [Breed] = { url in
        let apiKey = ProcessInfo.processInfo.environment["DOG_API_KEY"]
        ?? (Bundle.main.object(forInfoDictionaryKey: "DOG_API_KEY") as? String)

        guard let apiKey, apiKey.isEmpty == false else {
            throw BreedsClientError.missingAPIKey
        }

        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "x-api-key")

        do {
            let configuration = URLSessionConfiguration.default
            configuration.requestCachePolicy = .returnCacheDataElseLoad
            let urlSession = URLSession(configuration: configuration)

            let (data, response) = try await urlSession.data(for: request)

            guard let http = response as? HTTPURLResponse else {
                throw BreedsClientError.transportError(underlying: "Non-HTTP response")
            }

            guard (200...299).contains(http.statusCode) else {
                throw BreedsClientError.networkError(statusCode: http.statusCode)
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            do {
                let breeds = try decoder.decode([Breed].self, from: data)

                // TODO: Add pagination instead of returning fixed length
                return Array(breeds.prefix(50))
            } catch {
                throw BreedsClientError.decodingError
            }
        } catch {
            throw BreedsClientError.transportError(
                underlying: String(describing: error)
            )
        }
    }
}

extension BreedsClient: TestDependencyKey {
    static let testValue = BreedsClient(
        fetch: unimplemented("BreedsClient.fetch"),
        search: unimplemented("BreedsClient.fetch")
    )
}

extension DependencyValues {
    var breedsClient: BreedsClient {
        get { self[BreedsClient.self] }
        set { self[BreedsClient.self] = newValue }
    }
}

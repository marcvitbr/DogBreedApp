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
    static let liveValue = Self {
        guard let url = URL(string: "https://api.thedogapi.com/v1/breeds") else {
            throw BreedsClientError.invalidURL
        }

        let apiKey = ProcessInfo.processInfo.environment["DOG_API_KEY"]
            ?? (Bundle.main.object(forInfoDictionaryKey: "DOG_API_KEY") as? String)

        guard let apiKey, apiKey.isEmpty == false else {
            throw BreedsClientError.missingAPIKey
        }

        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "x-api-key")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let http = response as? HTTPURLResponse else {
                throw BreedsClientError.transportError(underlying: "Non-HTTP response")
            }

            guard (200...299).contains(http.statusCode) else {
                throw BreedsClientError.networkError(statusCode: http.statusCode)
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            do {
                return try decoder.decode([Breed].self, from: data)
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
    static let testValue = Self(
        fetch: unimplemented("BreedsClient.fetch")
    )
}

extension DependencyValues {
    var breedsClient: BreedsClient {
        get { self[BreedsClient.self] }
        set { self[BreedsClient.self] = newValue }
    }
}

//
//  BreedTests.swift
//  DogBreedsApp
//
//  Created by Marcelo Vitoria on 29/08/2025.
//

import XCTest
@testable import DogBreedApp

final class BreedTests: XCTestCase {
    func test_decodeSingleBreed() throws {
        let json = """
      {"id": 123, "name": "Husky", "breed_group": "Working", "origin": "Siberia", "temperament": "Friendly"}
      """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let breed = try decoder.decode(Breed.self, from: json)
        
        XCTAssertEqual(breed.id, 123)
        XCTAssertEqual(breed.name, "Husky")
        XCTAssertEqual(breed.breedGroup, "Working")
        XCTAssertEqual(breed.origin, "Siberia")
        XCTAssertEqual(breed.temperament, "Friendly")
    }
    
    func test_decodeArrayOfBreeds() throws {
        let json = """
      [
        {"id": 1, "name": "Labrador Retriever", "breed_group": "Sporting"},
        {"id": 7, "name": "Beagle", "breed_group": "Hound"}
      ]
      """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let breeds = try decoder.decode([Breed].self, from: json)
        
        XCTAssertEqual(breeds.count, 2)
        XCTAssertEqual(breeds[0].id, 1)
        XCTAssertEqual(breeds[0].name, "Labrador Retriever")
        XCTAssertEqual(breeds[0].breedGroup, "Sporting")
        
        XCTAssertEqual(breeds[1].id, 7)
        XCTAssertEqual(breeds[1].name, "Beagle")
        XCTAssertEqual(breeds[1].breedGroup, "Hound")
    }
}

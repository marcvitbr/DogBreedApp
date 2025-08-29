//
//  Breed.swift
//  DogBreedsApp
//
//  Created by Marcelo Vitoria on 29/08/2025.
//

import SwiftData

@Model
final class Breed: Identifiable, Equatable, Decodable {

    @Attribute(.unique)
    var id: Int
    var name: String
    var breedGroup: String?
    var temperament: String?
    var origin: String?

    init(
        id: Int,
        name: String,
        breedGroup: String?,
        temperament: String?,
        origin: String?
    ) {
        self.id = id
        self.name = name
        self.breedGroup = breedGroup
        self.temperament = temperament
        self.origin = origin
    }

    convenience init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)

        let idString = try container.decode(Int.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let breedGroup = try container.decodeIfPresent(String.self, forKey: .breedGroup)
        let origin = try container.decodeIfPresent(String.self, forKey: .origin)
        let temperament = try container.decodeIfPresent(String.self, forKey: .temperament)

        self.init(
          id: idString,
          name: name,
          breedGroup: breedGroup,
          temperament: temperament,
          origin: origin
        )
      }

    static func == (lhs: Breed, rhs: Breed) -> Bool {
      lhs.id == rhs.id &&
      lhs.name == rhs.name &&
      lhs.breedGroup == rhs.breedGroup &&
      lhs.origin == rhs.origin &&
      lhs.temperament == rhs.temperament
    }

    enum CodingKeys: String, CodingKey {
      case id
      case name
      case breedGroup = "breed_group"
      case origin
      case temperament
    }
}

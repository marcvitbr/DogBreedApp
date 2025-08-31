//
//  Breed.swift
//  DogBreedsApp
//
//  Created by Marcelo Vitoria on 29/08/2025.
//

import SwiftData
import Foundation

@Model
final class Breed: Identifiable, Equatable, Decodable {
    @Attribute(.unique)
    var id: Int
    var name: String
    var breedGroup: String?
    var temperament: String?
    var origin: String?
    var referenceImageId: String?
    var imageURL: URL?

    init(
        id: Int,
        name: String,
        breedGroup: String?,
        temperament: String?,
        origin: String?,
        referenceImageId: String? = nil,
        imageURL: URL? = nil
    ) {
        self.id = id
        self.name = name
        self.breedGroup = breedGroup
        self.temperament = temperament
        self.origin = origin
        self.referenceImageId = referenceImageId
        self.imageURL = imageURL
    }

    convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let idString = try container.decode(Int.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let breedGroup = try container.decodeIfPresent(String.self, forKey: .breedGroup)
        let origin = try container.decodeIfPresent(String.self, forKey: .origin)
        let temperament = try container.decodeIfPresent(String.self, forKey: .temperament)
        let referenceImageId = try container.decodeIfPresent(String.self, forKey: .referenceImageId)

        var imageURL: URL? = nil
        if container.contains(.image) {
            let image = try? container.nestedContainer(keyedBy: ImageKeys.self, forKey: .image)
            if let urlString = try image?.decodeIfPresent(String.self, forKey: .url) {
                imageURL = URL(string: urlString)
            }
        }

        self.init(
            id: idString,
            name: name,
            breedGroup: breedGroup,
            temperament: temperament,
            origin: origin,
            referenceImageId: referenceImageId,
            imageURL: imageURL
        )
    }

    static func == (lhs: Breed, rhs: Breed) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.breedGroup == rhs.breedGroup &&
        lhs.origin == rhs.origin &&
        lhs.temperament == rhs.temperament &&
        lhs.referenceImageId == rhs.referenceImageId &&
        lhs.imageURL == rhs.imageURL
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case breedGroup = "breed_group"
        case origin
        case temperament
        case referenceImageId = "reference_image_id"
        case image
    }

    private enum ImageKeys: String, CodingKey {
        case id
        case url
        case width
        case height
    }

    var imageResolvedURL: URL? {
        if let url = imageURL {
            return url
        }

        if let ref = referenceImageId {
            return URL(string: "https://cdn2.thedogapi.com/images/\(ref).jpg")
        }

        return nil
    }
}

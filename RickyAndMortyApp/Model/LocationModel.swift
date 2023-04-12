//
//  LocationModel.swift
//  RickyAndMortyApp
//
//  Created by Furkan Erdoğan on 10.04.2023.
//

import SwiftUI

struct LocationSchema: Codable {
    let info: LocationSchemaInfo
    let results: [LocationSchemaResult]
}

// MARK: - Info
struct LocationSchemaInfo: Codable {
    let count, pages: Int
    let next: String
    let prev: JSONNull?
}

// MARK: - Result
struct LocationSchemaResult: Codable, Identifiable {
    let id: Int
    let name, type, dimension: String
    let residents: [String]
    let url: String
    let created: String
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

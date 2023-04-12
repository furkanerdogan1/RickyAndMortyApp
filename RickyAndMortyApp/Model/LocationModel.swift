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


//
//  CharacterModel.swift
//  RickyAndMortyApp
//
//  Created by Furkan Erdoğan on 10.04.2023.
//

import SwiftUI

struct Character: Codable, Identifiable {
    let id: Int
    let name, status, species, type: String
    let gender: String
    let origin, location: Location
    let image: String 
    let episode: [String]
    let url: String
    let created: String
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let url: String
}

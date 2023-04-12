//
//  RickyAndMortyAppApp.swift
//  RickyAndMortyApp
//
//  Created by Furkan Erdoğan on 10.04.2023.
//

import SwiftUI

@main
struct RickyAndMortyAppApp: App {
    @State private var selectedSegment = 0
    
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}

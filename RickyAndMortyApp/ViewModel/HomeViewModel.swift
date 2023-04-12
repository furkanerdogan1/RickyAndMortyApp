//
//  HomeViewModel.swift
//  RickyAndMortyApp
//
//  Created by Furkan Erdoğan on 11.04.2023.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {

    enum ViewState {
        case START
        case LOADING
        case SUCCESS(users: [LocationSchemaResult])
        case FAILURE(error: String)
    }
    
    enum ViewState2 {
        case START
        case LOADING
        case SUCCESS(users: [Character])
        case FAILURE(error: String)
    }

    @Published var currentStateLocation: ViewState = .START
    @Published var currentStateCharacter: ViewState2 = .START
    @Published var charactersID: [String] = []
    @Published var locations: [LocationSchemaResult] = []
    private var cancelables = Set<AnyCancellable>()

    init() {
        getLocations(index: 0)
        
    }

    func getLocations(index: Int) {
        self.currentStateLocation = .LOADING
        Service.shared.getLocations(index)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Execution Finihsed.")
                case .failure(let error):
                    self.currentStateLocation = .FAILURE(error: error.localizedDescription)
                }
            } receiveValue: { users in
                self.currentStateLocation = .SUCCESS(users: users.results)
                self.locations.append(contentsOf: users.results)
                // Internet olmayınca uygulama çöküyo
                self.getCharacters(index: 0)
                
            }.store(in: &cancelables)
    }
    
    func getCharacters(index: Int) {
        self.charactersID = []
        for resident in locations[index].residents {
            self.charactersID.append(String(resident.split(separator: "/").last!))
        }
        
        self.currentStateCharacter = .LOADING
        Service.shared.getCharacters(chractersID: charactersID)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Execution Finihsed2.")
                case .failure(let error):
                    self.currentStateCharacter = .FAILURE(error: error.localizedDescription)
                }
            } receiveValue: { users in
                self.currentStateCharacter = .SUCCESS(users: users)
            }.store(in: &cancelables)
    }
}

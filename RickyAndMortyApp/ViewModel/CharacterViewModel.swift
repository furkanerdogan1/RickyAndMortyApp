//
//  CharacterViewModel.swift
//  RickyAndMortyApp
//
//  Created by Furkan Erdoğan on 11.04.2023.
//

import SwiftUI
import Combine

class CharacterViewModel: ObservableObject {

    
    enum ViewState2 {
        case START
        case LOADING
        case SUCCESS(users: [Character])
        case FAILURE(error: String)
    }
    
    enum ViewState3 {
        case START
        case LOADING
        case SUCCESS(users: [LocationSchemaResult])
        case FAILURE(error: String)
    }

    @Published var currentStateCharacter: ViewState2 = .START
    @Published var currentStateLocation: ViewState3 = .START
    @Published var charactersID: [String] = []
    private var cancelables = Set<AnyCancellable>()

    init() {
        getCharactersID()
    }
    
    func getCharactersID() {
        self.currentStateLocation = .LOADING
        Service.shared.getCharactersID()
            .sink { completion in
                switch completion {
                case .finished:
                    print("Execution Finihsed2.")
                case .failure(let error):
                    self.currentStateLocation = .FAILURE(error: error.localizedDescription)
                }
            } receiveValue: { users in
                self.currentStateLocation = .SUCCESS(users: users)
            }.store(in: &cancelables)
    }

    
    func getCharacters(_ charactersID: [String]) {
        self.currentStateCharacter = .LOADING
        print("Hey: \(self.charactersID)")
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

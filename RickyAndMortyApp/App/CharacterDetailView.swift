//
//  CharacterDetailView.swift
//  RickyAndMortyApp
//
//  Created by Furkan Erdoğan on 12.04.2023.
//

import SwiftUI

struct FruitDetailView: View {
    
    // MARK: - PROPERTIES
    
    var character: Character
    
    // MARK: - BODY
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 20) {
                    // HEADER
                    CharacterHeaderView(character: character)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        CharacterSubDetailView(character: character)
                        
                        
                    } //: VSTACK
                    .padding(.horizontal, 20)
                    .frame(maxWidth: 640, alignment: .center)
                    
                } //: VSTACK
                .navigationBarTitle(character.name, displayMode: .inline)
                .navigationBarHidden(true)
                
            } //: SCROLLVIEW
            
            
        } //: NAVIGATION
        .navigationBarTitle(character.name, displayMode: .inline)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

//// MARK: - PREVIEWS
//
//struct FruitDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        FruitDetailView(fruit: fruitsData[0])
//    }
//}

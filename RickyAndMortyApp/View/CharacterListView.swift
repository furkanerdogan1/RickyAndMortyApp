//
//  CharacterListView.swift
//  RickyAndMortyApp
//
//  Created by Furkan Erdoğan on 11.04.2023.
//

import SwiftUI

struct CharacterListView: View {
    let character: Character
    @State var initialImage = UIImage()
    @State var genderImage = UIImage()
    var body: some View {
        
        HStack {
            Image(uiImage: self.initialImage)
                .resizable()
                .cornerRadius(25)
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .onAppear {
                    guard let url = URL(string: self.character.image) else { return }
                    URLSession.shared.dataTask(with: url) { (data, response, error) in
                        guard let data = data else { return }
                        guard let image = UIImage(data: data) else { return }
                        
                        DispatchQueue.main.async {
                            self.initialImage = image
                        }
                        
                    }.resume()
            }.padding(10)
            
            Text(character.name)
                .font(.subheadline)
                .multilineTextAlignment(.leading)
            
            Image(uiImage: self.genderImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .onAppear {
                    if self.character.gender == "Female" {
                        self.genderImage = UIImage(named: "female")!
                    } else if self.character.gender == "Male" {
                        self.genderImage = UIImage(named: "male")!
                    } else if self.character.gender == "unknown" {
                        self.genderImage = UIImage(named: "question")!
                    } else {
                        self.genderImage = UIImage(named: "genderless")!
                    }
            }.padding(0)
        }
    }
}

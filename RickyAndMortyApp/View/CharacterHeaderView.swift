//
//  CharacterHeaderView.swift
//  RickyAndMortyApp
//
//  Created by Furkan Erdoğan on 12.04.2023.
//

import SwiftUI

struct CharacterHeaderView: View {
  // MARK: - PROPERTIES
  
  var character: Character
  
  @State private var isAnimatingImage: Bool = false
    @State var initialImage = UIImage()

  // MARK: - BODY

  var body: some View {
      
        Image(uiImage: self.initialImage)
        .resizable()
        .scaledToFit()
        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
        .scaleEffect(isAnimatingImage ? 1.0 : 0.6)
        .onAppear {
            
            guard let url = URL(string: self.character.image) else { return }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                guard let image = UIImage(data: data) else { return }
                
                DispatchQueue.main.async {
                    self.initialImage = image
                }
                
            }.resume()
                  withAnimation(.easeOut(duration: 0.5)) {
                    isAnimatingImage = true
                  }
        }
        .frame(width: 275, height: 275)
    
  }
}

// MARK: - PREVIEW

//struct FruitHeaderView_Previews: PreviewProvider {
//  static var previews: some View {
//    CharacterHeaderView(character: Character(id: 1, name: "Furkan", status: "aaa", species: "bbb", type: "ccc", gender: "male", origin: <#T##Location#>, location: <#T##Location#>, image: <#T##String#>, episode: <#T##[String]#>, url: <#T##String#>, created: <#T##String#>))
//      .previewLayout(.fixed(width: 375, height: 440))
//  }
//}

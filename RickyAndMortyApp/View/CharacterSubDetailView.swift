//
//  CharacterSubDetailView.swift
//  RickyAndMortyApp
//
//  Created by Furkan Erdoğan on 12.04.2023.
//

import SwiftUI

struct CharacterSubDetailView: View {
  // MARK: - PROPERTIES
  
  var character: Character
    @State var episodes: [String] = []
    @State var episodesNumber: String = ""
    @State var createdDate: String = ""
    

  // MARK: - BODY

  var body: some View {
      
      VStack(alignment: .leading, spacing: 5) {
          HStack {
              Text("Status:")
                  .font(.custom("Avenir", size: 22).bold())
              Text(character.status)
                  .font(.custom("Avenir", size: 22))
          }
          
          HStack(spacing: 20) {
              Text("Specy:")
                  .font(.custom("Avenir", size: 22).bold())
              Text(character.species)
                  .font(.custom("Avenir", size: 22))
          }
          
          HStack {
              Text("Gender:")
                  .font(.custom("Avenir", size: 22).bold())
              Text(character.gender)
                  .font(.custom("Avenir", size: 22))
          }
          
          HStack {
              Text("Origin:")
                  .font(.custom("Avenir", size: 22).bold())
              Text(character.origin.name)
                  .font(.custom("Avenir", size: 22))
          }
          
          HStack {
              Text("Lacation:")
                  .font(.custom("Avenir", size: 22).bold())
              Text(character.location.name)
                  .font(.custom("Avenir", size: 22))
          }
          
          HStack {
              Text("Episodes:")
                  .font(.custom("Avenir", size: 22).bold())
              
              Text(self.episodesNumber)
                  .font(.custom("Avenir", size: 22))
                  .onAppear {
                      self.episodesNumber = self.getEpisode()
                  }
          }
          
          HStack {
              Text("Created at (in API):")
                  .font(.custom("Avenir", size: 22).bold())
              Text(self.createdDate)
                  .font(.custom("Avenir", size: 22))
                  .onAppear {
                      
                      self.createdDate = getDate()
                  }
          }
          
      }.frame(maxWidth: .infinity, alignment: .leading)
    
  }
    
    func getEpisode() -> String {
        for ep in character.episode {
            self.episodes.append(String(ep.split(separator: "/").last!))
        }
        
        
        return self.episodes.joined(separator: ",")
    }
    
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: character.created)
        
        return "\(date!.formatted(.dateTime.day().month().year())), \(date!.formatted(.dateTime.hour().minute()))"
    }
}



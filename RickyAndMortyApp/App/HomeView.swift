//
//  HomeView.swift
//  RickyAndMortyApp
//
//  Created by Furkan Erdoğan on 11.04.2023.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    
    @State var selectedIndex: Int = 0
    
    @Namespace var namespace
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                if case .LOADING = viewModel.currentStateLocation {
                } else if case .SUCCESS(let users) = viewModel.currentStateLocation {
                    ScrollViewReader { proxy in
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(users.indices, id: \.self) { index in
                                    Text(users[index].name)
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .padding(.horizontal)
                                        .padding(.vertical, 8.0)
                                        .matchedGeometryEffect(
                                            id: index,
                                            in: namespace,
                                            isSource: true
                                        )
                                        .onTapGesture {
                                            withAnimation {
                                                selectedIndex = index
                                                self.viewModel.getCharacters(index: index)
                                                proxy.scrollTo(index)
                                            }
                                        }
                                }
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(8.0)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Material.regular)
                                .matchedGeometryEffect(
                                    id: self.selectedIndex,
                                    in: namespace,
                                    isSource: false
                                )
                        }
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Material.thin)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    .padding(.leading)
                    .padding(.trailing)
                    
                } else if case .FAILURE(let error) = viewModel.currentStateLocation {
                    VStack(alignment: .center) {
                        Spacer()
                        Text(error)
                            .font(.headline.bold())
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .padding()
                }
                
                
                List {
                    if case .LOADING = viewModel.currentStateCharacter {
                    } else if case .SUCCESS(let users) = viewModel.currentStateCharacter {
                        ForEach(users, id: \.id) { user in
                            CharacterListView(character: user)
                        }
                        
                    } else if case .FAILURE(let error) = viewModel.currentStateCharacter {
                        VStack(alignment: .center) {
                            Spacer()
                            Text(error)
                                .font(.headline.bold())
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                        .padding()
                    }
                }
            }
            
            .navigationBarTitle("Ricky And Morty", displayMode: .large)
        }
    }
    
    
    func loaderView() -> some View {
        ZStack {
            Color.black.opacity(0.05)
                .ignoresSafeArea()
            ProgressView()
                .scaleEffect(1, anchor: .center)
                .progressViewStyle(CircularProgressViewStyle(tint: .gray))
        }
    }
}




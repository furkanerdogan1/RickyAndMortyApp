//
//  SplashView.swift
//  RickyAndMortyApp
//
//  Created by Furkan Erdoğan on 12.04.2023.
//

import SwiftUI

struct SplashView: View {
    
    let savedSplash = UserDefaults.standard.string(forKey: "isShowSplash")
    @State var isActive: Bool = false
    
    
    var body: some View {
        ZStack {
            if self.isActive {
                HomeView()
            } else {
                
                VStack {
                    ZStack {
                        LottieView()
                            .frame(width: 275, height: 275)
                        Image("rickAndMortyLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 275, height: 275)
                    }
                    Text(savedSplash ?? "Welcome!")
                        .font(.custom("Avenir", size: 42).bold().italic())
                        .onAppear {
                            UserDefaults.standard.set("Hello!", forKey: "isShowSplash")
                        }
                    
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
        
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}

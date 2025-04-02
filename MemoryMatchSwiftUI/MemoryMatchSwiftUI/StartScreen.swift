//
//  ContentView.swift
//  MemoryMatchSwiftUI
//
//  Created by StudentPM on 3/24/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack(spacing: 300){
                //The title
                Text("EmojiMatch")
                    .frame(width: 300, height: 85)
                    .background(.orange)
                    .foregroundColor(.white)
                    .cornerRadius(6.0)
                    .font(.system(size: 50))
                
                //The start button, when clicked it will take you to the game screen
                NavigationLink(destination: GameScreen().navigationBarBackButtonHidden(true)){
                    Text("Start")
                        .frame(width: 160, height: 80)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(6.0)
                        .font(.system(size: 50))
                }
            }
            .padding()
            .background(Image("Image")) //adds the background image in the start screen
        }
    }
}

#Preview {
    ContentView()
}

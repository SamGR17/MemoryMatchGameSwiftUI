//
//  FinishScreen.swift
//  MemoryMatchSwiftUI
//
//  Created by StudentPM on 3/24/25.
//

import SwiftUI

struct FinishScreen: View {
    var body: some View {
        NavigationView{
            ZStack{
                Circle()
                    .foregroundColor(.red.opacity(0.4))
                    .frame(width: 400, height: 400)
                    .position(x: 25, y: 30)
                
                Circle()
                    .foregroundColor(Color(red: 0.8, green: 0.95, blue: 0.35).opacity(0.5))
                    .frame(width: 400, height: 400)
                    .position(x: 370, y: 730)
                
                Text("😃")
                    .font(.system(size: 150))
                    .position(x: 200, y: 275)
                
                Text("Great Job!")
                    .font(.system(size: 45))
                    .position(x: 200, y: 400)
                
                
                NavigationLink(destination: GameScreen().navigationBarBackButtonHidden(true)){
                    Text("Play Again")
                        .frame(width: 280, height: 80)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(6.0)
                        .font(.system(size: 50))
                        .position(x: 200, y: 500)
                }
            }
        }
    }
}

#Preview {
    FinishScreen()
}

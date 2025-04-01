//
//  GameScreen.swift
//  MemoryMatchSwiftUI
//
//  Created by StudentPM on 3/24/25.
//

import SwiftUI

struct GameScreen: View {
    @State var cardsFlipped: [Bool] = Array(repeating: false, count: 16)
    @State var emojis = ["😀", "😀" ,"😁", "😁", "😂", "😂", "🤣", "🤣", "😃", "😃", "😄", "😄"].shuffled()
    
    @State private var pickOne: Int = -1
    @State private var pickTwo: Int = -1
    @State private var score: Int = 0
    @State private var gameFinished: Bool = false
    
    let emojiColumns: [GridItem] = [
        GridItem(.fixed(50), spacing: 50, alignment: nil),
        GridItem(.fixed(50), spacing: 50, alignment: nil),
        GridItem(.fixed(50), spacing: 50, alignment: nil)
    ]
    
    
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
            
            Text("Current Score: \(score)")
                .font(.system(size: 40))
                .position(x: 195, y: 100)
            
            LazyVGrid(columns: emojiColumns){
                ForEach(emojis.indices, id: \.self){ i in
                    Button(action: {guessMatch(index: i)}, label: {
                        emojiBox(emoji: emojis[i], isFlipped: cardsFlipped[i])
                            
                    })
                }
            }
            
            if score >= 6{
                    HStack{
                        NavigationLink(destination: FinishScreen().navigationBarBackButtonHidden(true)){
                            Text("Next")
                                .frame(width: 130, height: 60)
                                .background(.blue)
                                .foregroundColor(.white)
                                .cornerRadius(6.0)
                                .font(.system(size: 40))
                                .position(x: 118, y: 700)
                        }
                        Button(action: {retryButtonAction()}, label: {
                            Text("Retry")
                                .frame(width: 130, height: 60)
                                .background(.blue)
                                .foregroundColor(.white)
                                .cornerRadius(6.0)
                                .font(.system(size: 40))
                                .position(x: 65, y: 700)
                        })
                    }
                }
            }
            
        }
    }
    
    func guessMatch(index: Int){
        if cardsFlipped[index] == true{
            return
        }
        cardsFlipped[index] = true
        
        if pickOne == -1{
            pickOne = index
            cardsFlipped[pickOne] = true
        }
        else{
            pickTwo = index
            cardsFlipped[pickTwo] = true
            checkIfMatching(index: index)
        }
    }
    
    func checkIfMatching(index: Int){
        if emojis[pickOne] == emojis[pickTwo]{
            score += 1
            pickOne = -1
            pickTwo = -1
        }
        else{
            cardsFlipped[pickOne] = false
            cardsFlipped[pickTwo] = false
            pickOne = -1
            pickTwo = -1
        }
    }
    
    func retryButtonAction(){
        score = 0
        emojis.shuffle()
        
        for i in cardsFlipped.indices{
            cardsFlipped[i] = false
        }
    }
}

struct emojiBox: View{
    var emoji: String = ""
    var isFlipped: Bool = false
    
    var body: some View{
        ZStack{
            Text("\(emoji)")
                
            RoundedRectangle(cornerRadius: 10)
                .fill(isFlipped == false ? .blue : Color.white.opacity(0.01))
                .frame(width: 80, height: 80)
                .padding()
                
        }
        
    }
}

#Preview {
    GameScreen()
}

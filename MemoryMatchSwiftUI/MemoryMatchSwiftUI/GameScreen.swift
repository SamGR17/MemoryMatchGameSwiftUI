//
//  GameScreen.swift
//  MemoryMatchSwiftUI
//
//  Created by StudentPM on 3/24/25.
//

import SwiftUI

struct GameScreen: View {
    @State var cardsFlipped: [Bool] = Array(repeating: false, count: 16)
    @State var emojis = ["😀", "😀" ,"😁", "😁", "😂", "😂", "🤣", "🤣", "😃", "😃", "😄", "😄"].shuffled() //array containing all the emojis used for the game
    
    //These 2 variables are meant for when you pick the cards you want to guess
    @State private var pickOne: Int = -1
    @State private var pickTwo: Int = -1
    
    @State private var score: Int = 0 //variable meant to be the score
    
    // this creates the columns for the game screen
    let emojiColumns: [GridItem] = [
        GridItem(.fixed(50), spacing: 50, alignment: nil),
        GridItem(.fixed(50), spacing: 50, alignment: nil),
        GridItem(.fixed(50), spacing: 50, alignment: nil)
    ]
    
    
    var body: some View {
        NavigationView{
        ZStack{
            Circle() // the red circle for the background
                .foregroundColor(.red.opacity(0.4))
                .frame(width: 400, height: 400)
                .position(x: 25, y: 30)
            
            Circle() // the green circle for the background
                .foregroundColor(Color(red: 0.8, green: 0.95, blue: 0.35).opacity(0.5))
                .frame(width: 400, height: 400)
                .position(x: 370, y: 730)
            
            Text("Current Score: \(score)") //Text to display your current score
                .font(.system(size: 40))
                .position(x: 195, y: 100)
            
            //blue boxes and emojis are displayed in this LazyVGrid in columns
            LazyVGrid(columns: emojiColumns){
                //for each emoji in the array, they are made into buttons
                ForEach(emojis.indices, id: \.self){ i in
                    Button(action: {guessMatch(index: i)}, label: {
                        emojiBox(emoji: emojis[i], isFlipped: cardsFlipped[i])
                            
                    })
                }
            }
            
            //if you get a score of 6 or higher (just in case), the Next and Retry button pop up at the bottom of the screen
            if score >= 6{
                    HStack{
                        //This is the Next button, when it is clicked, it will navigate you to the finish screen
                        NavigationLink(destination: FinishScreen().navigationBarBackButtonHidden(true)){
                            Text("Next")
                                .frame(width: 130, height: 60)
                                .background(.blue)
                                .foregroundColor(.white)
                                .cornerRadius(6.0)
                                .font(.system(size: 40))
                                .position(x: 118, y: 700)
                        }
                        //This is the Retry button, when it is clicked, it reset the score to 0, shuffle the emojis, and flip all the cards again
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
        //meant to prevent you from clicking the same emoji over and over again
        if cardsFlipped[index] == true{
            return
        }
        cardsFlipped[index] = true
        
        //if pickOne is equal to -1, it will change it's value to the Int of index, and will change the value of the index in the cardsFlipped array to true
        if pickOne == -1{
            pickOne = index
            cardsFlipped[pickOne] = true
        }
        else{ // if pickOne is not equal to -1, it will change pickTwo's value to the Int of the index, and will change the value of the index in the cardsFlipped array to true, and it will run the checkIfMatching function
            pickTwo = index
            cardsFlipped[pickTwo] = true
            checkIfMatching(index: index)
        }
    }
    
    func checkIfMatching(index: Int){
        //if the emojis in the chosen indices are equal to each other, it will add 1 to your score and reset the pickOne and pickTwo variables to their original values
        if emojis[pickOne] == emojis[pickTwo]{
            score += 1
            pickOne = -1
            pickTwo = -1
        }
        else{ // if they do not equal to each other, it will flip the chosen cards back by making them false again, and reset the pickOne and pickTwo variables to their original values
            cardsFlipped[pickOne] = false
            cardsFlipped[pickTwo] = false
            pickOne = -1
            pickTwo = -1
        }
    }
    
    //when the retry button is clicked, it will reset the score to 0, shuffle the emojis array, and flip all the cards again by making them false
    func retryButtonAction(){
        score = 0
        emojis.shuffle()
        
        //makes all of the cards' values false, making them flip back
        for i in cardsFlipped.indices{
            cardsFlipped[i] = false
        }
    }
}

//this struct is mean to style all the buttons for each emoji
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

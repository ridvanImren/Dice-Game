//
//  GameView.swift
//  Dice Game
//
//  Created by Rıdvan İmren on 23.01.2022.
//

import SwiftUI

struct GameView: View {
    @StateObject private var game = Game(numRows: 8, numCols: 5)

    var body: some View {
        ZStack{
            
        VStack(spacing: 5) {
            
            Text("Dice Game")
                .font(.largeTitle.bold())

            
            HStack {
                Button {
                    game.openMenu()
                } label: {
                    Text("Menu")
                        
                        .padding(3)
                        .background(.secondary)
                        .foregroundColor(.primary)
                        .font(.headline)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                }
                Spacer()
                Spacer()
                Button {
                    
                    game.restartGame()
                    
                } label: {
                    Text("Restart")
                    
                        .padding(3)
                        .background(.secondary)
                        .foregroundColor(.primary)
                        .font(.headline)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                }
            }
            
            HStack(spacing: 20) {
                Text("Blue: \(game.playerOneScore)")
                    .foregroundColor(game.activePlayer == .playerOne ? Player.playerOne.color : Color(white: 0.7))
                    .font(.headline)
                Text("Red: \(game.playerTwoScore)")
                    .foregroundColor(game.activePlayer == .playerTwo ? Player.playerTwo.color : Color(white: 0.7))
                    .font(.headline)
            }
            
            ForEach(game.rows.indices, id: \.self) { row in
                HStack(spacing: 5) {
                    ForEach(game.rows[row]) { dice in
                        DiceView(dice: dice)
                            .onTapGesture {
                                game.increment(dice)
                                print(game.state)
                            }
                    }
                }
            }
        }
        .padding(.horizontal)
        .opacity(1-game.menuChangeAmount*0.8)
            
            MenuView(game: game)
    }
       
    }
    
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

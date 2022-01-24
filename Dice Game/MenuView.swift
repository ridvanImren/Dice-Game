//
//  MenuView.swift
//  Dice Game
//
//  Created by Rıdvan İmren on 24.01.2022.
//

import SwiftUI

struct MenuView: View {
    @StateObject var game: Game
    
    var body: some View {
        VStack {
            
            
            Button {
                game.startGame(.twoPlayer)
            } label: {
                Text("Player vs Player")
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(gradient: Gradient(colors: [.white, .red, .white, .red, .white]), startPoint: .leading, endPoint: .trailing))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(.black, lineWidth:1))
                    
            }
            .padding([.vertical])
            Button {
                game.startGame(.vsAi)
            } label: {
                Text("Player vs AI")
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(gradient: Gradient(colors: [.white, .red, .white, .red, .white]), startPoint: .leading, endPoint: .trailing))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(.black, lineWidth:1))

            }

                
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [.black, .red, .white, .red, .black]), startPoint: .leading, endPoint: .trailing))
        .clipShape(
        RoundedRectangle(cornerRadius: 15)
        )
        .opacity(game.menuChangeAmount)
        .padding([.horizontal], 50)
    }
}


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(game: Game(numRows: 8, numCols: 7))
    }
}

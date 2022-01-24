//
//  Dice.swift
//  Dice Game
//
//  Created by Rıdvan İmren on 23.01.2022.
//

import Foundation

class Dice: ObservableObject, Equatable, Identifiable, Comparable {

    
    
    
    @Published var value = 1
    @Published var changeAmount = 0.0
    
    let id = UUID()
    var owner = Player.none
    let row: Int
    let col: Int
    let neighbors: Int
    var aiScore = -100
    
    static func == (lhs: Dice, rhs: Dice) -> Bool {
        lhs.aiScore == rhs.aiScore
    }
    
    init(row: Int, col: Int, neighbors: Int) {
        self.row = row
        self.col = col
        self.neighbors = neighbors
    }
    
    static func < (lhs: Dice, rhs: Dice) -> Bool {
        rhs.aiScore < lhs.aiScore
    }
}

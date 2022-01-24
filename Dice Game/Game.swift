//
//  Game.swift
//  Dice Game
//
//  Created by Rıdvan İmren on 23.01.2022.
//

//import Foundation
import SwiftUI

class Game: ObservableObject {
    var rows: [[Dice]]
    
    private let numRows: Int
    private let numCols: Int
    
    @Published var activePlayer = Player.playerOne
    @Published var state = GameState.waiting
    @Published var gameMode = GameMode.vsAi
    @Published var playerOneScore = 0
    @Published var playerTwoScore = 0
    
    @Published var menuChangeAmount = 1.0
    
    var changeList = [Dice]()
    var aiCheckList = [Dice]()
    private func countNeighbors(row: Int, col:Int) -> Int {
        var result = 0
        if col > 0 {
            result += 1
        }
        if col < numCols - 1 {
            result += 1
        }
        if row > 0 {
            result += 1
        }
        if row < numRows - 1 {
            result += 1
        }
        
        return result
    }
    
    private func getNeighborDice(row: Int, col:Int) -> [Dice] {
        var result = [Dice]()
        if col > 0 {
            result.append(rows[row][col - 1])
        }
        if col < numCols - 1 {
            result.append(rows[row][col + 1])
        }
        if row > 0 {
            result.append(rows[row - 1][col])
        }
        if row < numRows - 1 {
            result.append(rows[row + 1][col])
        }
        
        return result
    }
    
    func tapDice(_ dice: Dice) {
        
        dice.value += 1
        dice.owner = activePlayer
        dice.changeAmount = 1
        
        withAnimation {
            dice.changeAmount = 0
        }
        
        if dice.value > dice.neighbors {
            dice.value = 1
            for neighbor in getNeighborDice(row: dice.row, col: dice.col) {
                changeList.append(neighbor)
            }
           

        }
    }
    
    func runChangeList() {
        if changeList.isEmpty {
            changeTurn()
            return
        }
        
        let changedDices = changeList
        changeList.removeAll()
        
        for dice in changedDices {
            tapDice(dice)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.runChangeList()
        }

        playerOneScore = getScore(for: .playerOne)
        playerTwoScore = getScore(for: .playerTwo)
    }
    
    private func changeTurn() {
        if activePlayer == .playerOne {
            activePlayer = .playerTwo
            state = .aIthinking
            
            switch gameMode {
                
            case .twoPlayer:
                return
            case .vsAi:
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.startAiTurn()
                }
            }
            
            
        } else {
            activePlayer = .playerOne
            state = .waiting
        }
    }
    
    func increment(_ dice: Dice) {
        guard state == .waiting || state == .aIthinking else { return }
        guard dice.owner == .none || dice.owner == activePlayer else { return }
        state = .changing
        changeList.append(dice)
        runChangeList()
        
    }
    
    private func getScore(for player: Player) -> Int {
        var count = 0
        
        for row in rows {
            for col in row {
                if col.owner == player {
                    count += 1
                }
            }
        }
        
        return count
    }
    
    
    private func checkMoveAI(_ dice: Dice) {
        guard dice.owner == .playerTwo else { return }
        aiCheckList.append(dice)

        dice.aiScore = 0

        if dice.value + 1 > dice.neighbors {
            for neighbor in getNeighborDice(row: dice.row, col: dice.col) {
                checkMoveAI(neighbor)
                dice.aiScore += 1
            }
        }

    }
//
//    private func getBestMove() -> Dice {
//
//        var bestDice = [Dice]()
//
//        for row in rows {
//            for die in row {
//                if aiCheckList.contains(die) { continue }
//                aiCheckList.removeAll()
//
//                checkMoveAI(die)
//
//                var score = 0
//
//                }
//        }
//
//
//        return bestDice.sorted().first ?? Dice(row: 0, col: 0, neighbors: 0)
//
//    }
    
    private func getAiMove() -> Dice? {
        aiCheckList.removeAll()
        for row in rows {
            for die in row {
                if die.owner != .playerOne {
                    aiCheckList.append(die)
                }
            }
        }
        
        return aiCheckList.randomElement()
    }
    
    private func startAiTurn() {
        if let aiDice = getAiMove() {
            changeList.append(aiDice)
            state = .changing
            runChangeList()
        } else {
            print("Game ended")
        }
        
    }
    
    func restartGame() {
//
        
        self.rows = [[Dice]]()
        
        for rowCount in 0..<numRows {
            var newRow = [Dice]()
            
            for colCount in 0..<numCols {
                let dice = Dice(row: rowCount, col: colCount, neighbors: countNeighbors(row: rowCount, col: colCount))
                newRow.append(dice)
            }
            
            self.rows.append(newRow)
        }
        playerOneScore = 0
        playerTwoScore = 0
    }
    
    func startGame(_ gameMode: GameMode) {
        self.gameMode = gameMode
        restartGame()
        

        withAnimation(Animation.linear(duration: 2)) {
            menuChangeAmount = 0.0
        }
    }
    
    func openMenu() {
        restartGame()
        
        menuChangeAmount = 0
        withAnimation(Animation.linear(duration: 2)) {
            menuChangeAmount = 1
        }
    }
    
    init(numRows: Int, numCols: Int) {
        self.numCols = numCols
        self.numRows = numRows
        
        self.rows = [[Dice]]()
        
        for rowCount in 0..<numRows {
            var newRow = [Dice]()
            
            for colCount in 0..<numCols {
                let dice = Dice(row: rowCount, col: colCount, neighbors: countNeighbors(row: rowCount, col: colCount))
                newRow.append(dice)
            }
            
            self.rows.append(newRow)
        }
    }
}

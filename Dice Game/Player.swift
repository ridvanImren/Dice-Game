//
//  Player.swift
//  Dice Game
//
//  Created by Rıdvan İmren on 23.01.2022.
//

import SwiftUI

enum Player {
    case none, playerOne, playerTwo
    
    var color: Color {
        switch self {
        case .none:
            return Color(white: 0.6)
        case .playerOne:
            return .blue
        case .playerTwo:
            return .yellow
        }
    }
    
}


//
//  Enums.swift
//  Memory Match
//
//  Created by Brendan on 2/19/24.
//

import Foundation

struct GamePiece {
    let id = UUID()
    let symbol: String
}

enum GameThemeOptions: String, CaseIterable {
    case defaultTheme = "Default"
    case animals = "Animals"
    case foods = "Foods"
    case elements = "Elements"

    private var allTokens: [String] {
        switch self {
        case .defaultTheme:
            return ["🔥", "⭐️", "🎱", "❤️", "🤖", "🍔", "🚗", "💎"]
        case .animals:
            return ["🐠","🦆","🐢","🐪","🐖","🐈‍⬛","🐿️","🐍"]
        case .foods:
            return ["🍎","🍌","🍇","🫐","🍔","🍕","🥗","🍩"]
        case .elements:
            return ["🔥", "❄️", "💨", "💧", "🌱", "🌵", "⚡️", "🌸"]
        }
    }

    var gameBoard: [GamePiece] {
        let selectedEmojis = allTokens.shuffled().prefix(8)
        let pairs = selectedEmojis + selectedEmojis
        return pairs.shuffled().map {GamePiece(symbol: $0)}
    }
}

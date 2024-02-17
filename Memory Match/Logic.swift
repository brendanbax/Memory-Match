//
//  Logic.swift
//  Memory Match
//
//  Created by Brendan on 2/15/24.
//

import Foundation

struct GamePiece {
    let id = UUID()
    let symbol: String
}

let symbols = ["🔥", "⭐️", "🎱", "❤️", "🤖", "🍔", "🚗", "💎"]
let animals = ["🐠","🦆","🐢","🐪","🐖","🐈‍⬛","🐿️","🐍"]
let food = ["🍎","🍌","🍇","🫐","🍔","🍕","🥗","🍩"]
let elements = ["🔥", "❄️", "💨", "💧", "🌱", "🌵", "⚡️", "🌸"]

func generatePieces (theme: String)-> [GamePiece] {
    var pieces: [GamePiece] = []
    var themePieces: [String] = []

    switch theme {
        case "animals":
            themePieces = animals
        case "food":
            themePieces = food
        case "elements":
            themePieces = elements
        default:
            themePieces = symbols
    }

    print("Generating pieces...")
    themePieces.forEach { symbol in
        pieces.append(GamePiece(symbol: symbol))
        pieces.append(GamePiece(symbol: symbol))
        print(symbol)
        print(symbol)
    }
    pieces.shuffle()

    return pieces
}

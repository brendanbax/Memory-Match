//
//  ContentView.swift
//  Memory Match
//
//  Created by Brendan on 2/15/24.
//

import SwiftUI

func startGame() {
    print("Starting game")
}

struct ContentView: View {
    let gameThemeOptions = ["default", "animals", "food", "elements"]
    let rows = [GridItem](repeating: GridItem(.fixed(75)), count: 4)

    @State private var selectedTheme: String = ""
    @State private var sessionDuration: Int = 0
    @State private var score: Int = 0
    @State private var activePiece: String = ""

    var gameBoard: [GamePiece] {
        generatePieces(theme: selectedTheme)
    }

    var body: some View {
        VStack {
            Spacer()
            Text("Game Clock")
            Spacer()
            LazyHGrid(rows: rows, spacing: 10, content: {
                ForEach(gameBoard, id: \.id) { piece in
                    BoardItem(piece: piece)
                }
            })
            Spacer()
            HStack {
                Text("Theme:")
                Picker("Select a theme", selection: $selectedTheme) {
                                ForEach(gameThemeOptions, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.menu)
            }
            Spacer()
            Button("Start", systemImage: "play", action: startGame)
            Spacer()
        }
    }
}

struct BoardItem: View {
    var piece: GamePiece
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .stroke(.blue, lineWidth: 3)
                .aspectRatio(contentMode: .fit)
            Text(piece.symbol)
                .font(.largeTitle)
                .padding()
                .cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  Memory Match
//
//  Created by Brendan on 2/15/24.
//

import SwiftUI

// Define GameData object for use in global app state
class GameData: ObservableObject {
    @Published var isTimerRunning = false
    @Published var time = ""
    @Published var score = ""
}

struct ContentView: View {
    @StateObject var gameData = GameData() // creates GameData object, puts in environment

    func resetGame() {
        gameData.score = ""
        gameData.time = ""
        gameData.isTimerRunning = false
    }

    var body: some View {
        VStack {
            Spacer()
            if gameData.isTimerRunning {
                TimerView()
            } else if gameData.score != "" {
                VStack {
                    Text("SCORE").font(Font.system(.title))
                    Text(gameData.score).font(Font.system(.largeTitle, design: .monospaced))
                    Button("Play again", action: resetGame)
                }
            }
            Spacer()
            GameBoardView()
            Spacer()
        }
        .environmentObject(gameData)
    }
}

#Preview {
    ContentView().environmentObject(GameData())
}

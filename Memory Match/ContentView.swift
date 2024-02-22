//
//  ContentView.swift
//  Memory Match
//
//  Created by Brendan on 2/15/24.
//

import SwiftUI

struct ContentView: View {
    @State private var score: String = ""
    @State private var activePiece: String = ""
    @State private var isTimerRunning: Bool = false
    @State private var timerString: String = "0.00"

    func startGame() {
        self.isTimerRunning.toggle()
    }

    func stopGame() {
        self.score = self.timerString
        self.isTimerRunning = false
        print(self.timerString)
    }

    var body: some View {
        VStack {
            Spacer()
            if self.isTimerRunning {
                TimerView(isTimerRunning: $isTimerRunning, timerString: $timerString)
            } else if self.score != "" {
                VStack {
                    Text("SCORE").font(Font.system(.title))
                    Text(self.score).font(Font.system(.largeTitle, design: .monospaced))
                }
            }
            Spacer()
            GameBoardView()
            Spacer()
            HStack {
                Button("Start", systemImage: "play", action: startGame)
                Button("Stop", systemImage: "stop", action: stopGame)
            }
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}

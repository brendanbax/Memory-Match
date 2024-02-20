//
//  ContentView.swift
//  Memory Match
//
//  Created by Brendan on 2/15/24.
//

import SwiftUI

struct ContentView: View {
    let rows = [GridItem](repeating: GridItem(.fixed(75)), count: 4)

    @State var selectedTheme: GameThemeOptions = .defaultTheme
    
    @State private var score: Int = 0
    @State private var activePiece: String = ""
    @State private var isTimerRunning = false
    @State private var startTime =  Date()
    @State private var timerString = "0.00"
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    func stopTimer() {
            self.timer.upstream.connect().cancel()
        }

    func startTimer() {
        self.timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    }

    func startGame() {
        if isTimerRunning {
            // stop UI updates
            self.stopTimer()
        } else {
            timerString = "0.00"
            startTime = Date()
            // start UI updates
            self.startTimer()
        }
        isTimerRunning.toggle()
    }

    var body: some View {
        VStack {
            Spacer()
            Text(timerString)
                .font(Font.system(.largeTitle, design: .monospaced))
                .onReceive(timer) { _ in
                if self.isTimerRunning {
                    timerString = String(format: "%.2f", (Date().timeIntervalSince( self.startTime)))
                }
            }
            Spacer()
            LazyHGrid(rows: rows, spacing: 10, content: {
                ForEach(selectedTheme.gameBoard, id: \.id) { piece in
                    BoardItem(piece: piece)
                }
            })
            Spacer()
            ThemePickerView(selectedTheme: $selectedTheme)
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

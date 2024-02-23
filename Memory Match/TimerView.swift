//
//  TimerView.swift
//  Memory Match
//
//  Created by Brendan on 2/20/24.
//

import SwiftUI

struct TimerView: View {
    @EnvironmentObject var gameData: GameData // consume GameData object

    @State private var startTime =  Date()
    @State private var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()

    var body: some View {
        Text(gameData.time)
            .font(Font.system(.largeTitle, design: .monospaced))
            .onChange(of: gameData.isTimerRunning) {
                if (gameData.isTimerRunning) {
                    startTime = Date()
                    gameData.time = "0.00"
                    timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
                } else {
                    startTime = Date()
                    gameData.time = "0.00"
                    timer.upstream.connect().cancel()
                }
            }
            .onReceive(timer) { _ in
                if gameData.isTimerRunning {
                    gameData.time = String(format: "%.2f", (Date().timeIntervalSince(startTime)))
            }
        }
    }
}

#Preview {
    TimerView().environmentObject(GameData()) // Need to provide env object to prevew
}

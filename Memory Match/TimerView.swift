//
//  TimerView.swift
//  Memory Match
//
//  Created by Brendan on 2/20/24.
//

import SwiftUI

struct TimerView: View {
    @Binding var isTimerRunning: Bool
    @Binding var timerString: String
    @State private var startTime =  Date()
    @State private var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()

    var body: some View {
        Text(timerString)
            .font(Font.system(.largeTitle, design: .monospaced))
            .onChange(of: isTimerRunning) {
                if (self.isTimerRunning) {
                    self.startTime = Date()
                    self.timerString = "0.00"
                    self.timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
                } else {
                    self.startTime = Date()
                    self.timerString = "0.00"
                    self.timer.upstream.connect().cancel()
                }
            }
            .onReceive(timer) { _ in
            if self.isTimerRunning {
                timerString = String(format: "%.2f", (Date().timeIntervalSince( self.startTime)))
            }
        }
    }
}

#Preview {
    TimerView(isTimerRunning: .constant(true), timerString: .constant("0.00"))
}

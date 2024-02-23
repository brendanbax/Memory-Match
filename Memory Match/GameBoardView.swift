//
//  GameBoardView.swift
//  Memory Match
//
//  Created by Brendan on 2/21/24.
//

import SwiftUI
import Foundation

struct GameBoardView: View {
    @EnvironmentObject var gameData: GameData
    
    @State private var selectedTheme: GameThemeOptions = .defaultTheme
    @State private var matchList: [GamePiece] = []
    @State private var selectedPieces: [GamePiece] = []

    let rows = [GridItem](repeating: GridItem(.fixed(75)), count: 4)

    func checkWin() {
        if matchList.count == selectedTheme.gameBoard.count {
            gameData.isTimerRunning = false
            gameData.score = gameData.time
        }
    }

    func handlePieceTap(selection: GamePiece) {
        // Start timer on first piece
        if !gameData.isTimerRunning {
            gameData.isTimerRunning = true
        }

        // Prevent selecting same piece twice, matched piece, limit selection to 2
        if selectedPieces.contains(where: { $0.id == selection.id }) ||
            matchList.contains(where: { $0.id == selection.id }) ||
            selectedPieces.count == 2 {
            return
        }
        // Append selection to array
        selectedPieces.append(selection)

        if selectedPieces.count == 2 {
            let isMatch = selectedPieces[0].symbol == selectedPieces[1].symbol
            if isMatch {
                // Move selectedPieces into matchList
                matchList.append(contentsOf: selectedPieces)
                // Clear selectedPieces
                selectedPieces.removeAll()
                // Check win condition
                checkWin()
            } else {
                // Clear selection
                func callback() {
                    selectedPieces.removeAll()
                }
                // Delay so user can see revealed tile
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    callback()
                }
            }
        }
    }

    var body: some View {
        VStack {
            ThemePickerView(selectedTheme: $selectedTheme)
            LazyHGrid(rows: rows, spacing: 10, content: {
                ForEach(selectedTheme.gameBoard, id: \.id) { piece in
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                            .stroke(.blue, lineWidth: 3)
                            .aspectRatio(contentMode: .fit)
                        Text(piece.symbol)
                            .font(.largeTitle)
                            .padding()
                            .cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                            .opacity(selectedPieces.contains(where: { $0.id == piece.id }) || matchList.contains(where: { $0.id == piece.id }) ? 1 : 0)
                    }
                    .onTapGesture {
                        handlePieceTap(selection: piece)
                    }
                }
            })
        }
    }
}

#Preview {
    GameBoardView().environmentObject(GameData())
}

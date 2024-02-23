//
//  GameBoardView.swift
//  Memory Match
//
//  Created by Brendan on 2/21/24.
//

import SwiftUI
import Foundation

struct BoardItem: View {
    let piece: GamePiece

    @EnvironmentObject var gameData: GameData

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
                .opacity(gameData.selectedPieces.contains(where: { $0.id == piece.id }) || gameData.matchList.contains(where: { $0.id == piece.id }) ? 1 : 0)
        }
    }
}

struct GameBoardView: View {
    @EnvironmentObject var gameData: GameData
    
    @State private var selectedTheme: GameThemeOptions = .defaultTheme

    let rows = [GridItem](repeating: GridItem(.fixed(75)), count: 4)

    func checkWin() {
        if gameData.matchList.count == selectedTheme.gameBoard.count {
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
        if gameData.selectedPieces.contains(where: { $0.id == selection.id }) ||
            gameData.matchList.contains(where: { $0.id == selection.id }) ||
            gameData.selectedPieces.count == 2 {
            return
        }
        // Append selection to array
        gameData.selectedPieces.append(selection)

        if gameData.selectedPieces.count == 2 {
            let isMatch = gameData.selectedPieces[0].symbol == gameData.selectedPieces[1].symbol
            if isMatch {
                // Move selectedPieces into matchList
                gameData.matchList.append(contentsOf: gameData.selectedPieces)
                // Clear selectedPieces
                gameData.selectedPieces.removeAll()
                // Check win condition
                checkWin()
            } else {
                // Clear selection
                func callback() {
                    gameData.selectedPieces.removeAll()
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
                    BoardItem(piece: piece)
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

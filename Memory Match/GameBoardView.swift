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
    @Binding var selectedPieces: [GamePiece]
    @Binding var matchList: [GamePiece]

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
                .opacity(selectedPieces.contains(where: { $0.id == piece.id }) || matchList.contains(where: { $0.id == piece.id }) ? 1 : 0)
        }
    }
}

struct GameBoardView: View {
    let rows = [GridItem](repeating: GridItem(.fixed(75)), count: 4)
    @State private var selectedTheme: GameThemeOptions = .defaultTheme
    @State private var selectedPieces: [GamePiece] = []
    @State private var matchList: [GamePiece] = []

    func handlePieceTap(selection: GamePiece) {
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
            LazyHGrid(rows: rows, spacing: 10, content: {
                ForEach(selectedTheme.gameBoard, id: \.id) { piece in
                    BoardItem(piece: piece, selectedPieces: $selectedPieces, matchList: $matchList)
                    .onTapGesture {
                        handlePieceTap(selection: piece)
                    }
                }
            })
            ThemePickerView(selectedTheme: $selectedTheme)
        }
    }
}

#Preview {
    GameBoardView()
}

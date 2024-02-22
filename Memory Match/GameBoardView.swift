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
    var visible: Bool

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
                .opacity(self.visible ? 1 : 0)
        }
    }
}

struct GameBoardView: View {
    let rows = [GridItem](repeating: GridItem(.fixed(75)), count: 4)
    @State private var selectedTheme: GameThemeOptions = .defaultTheme
    @State private var selectedPieces: [UUID] = []
    @State private var matchList: [UUID] = []

    func handlePieceTap(id: UUID) {
        selectedPieces.append(id)
        print(selectedPieces.contains(id) || matchList.contains(id))
    }

    var body: some View {
        VStack {
            LazyHGrid(rows: rows, spacing: 10, content: {
                ForEach(selectedTheme.gameBoard, id: \.id) { piece in
                    BoardItem(piece: piece, visible: self.selectedPieces.contains(piece.id) || self.matchList.contains(piece.id))
                        .onTapGesture {
                            handlePieceTap(id: piece.id)
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

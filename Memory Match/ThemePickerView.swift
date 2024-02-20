//
//  ThemePickerView.swift
//  Memory Match
//
//  Created by Brendan on 2/19/24.
//

import SwiftUI
import SwiftData

struct ThemePickerView: View {
    @Binding var selectedTheme: GameThemeOptions

    var body: some View {
        VStack {
            Menu {
                Button(action: {
                    selectedTheme = .defaultTheme
                }) {
                    Label("Default", systemImage: "paintbrush")
                }
                Button(action: {
                    selectedTheme = .animals
                }) {
                    Label("Animals", systemImage: "tortoise.fill")
                }
                Button(action: {
                    selectedTheme = .foods
                }) {
                    Label("Foods", systemImage: "leaf.fill")
                }
                Button(action: {
                    selectedTheme = .elements
                }) {
                    Label("Elements", systemImage: "flame.fill")
                }
            } label: {
                Label("Select theme: \(selectedTheme.rawValue)", systemImage: "list.dash")
                    .padding()
                    .foregroundColor(.blue)
            }
        }
    }
}

struct ThemePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ThemePickerView(selectedTheme: .constant(.defaultTheme))
    }
}

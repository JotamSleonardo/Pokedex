//
//  StatsView.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 3/27/24.
//

import SwiftUI

struct StatsView: View {
    @ObservedObject private(set) var viewModel: PokemonDetailsVM

    var body: some View {
        let pokemon = viewModel.pokemon
        let primaryColor = pokemon.primaryColor
        HStack {
            VStack(alignment: .leading, spacing: 15.0) {
                StatProgressBarView(value: 30, maxValue: 100, leadingText: "HP", progressBarColor: primaryColor)
                StatProgressBarView(value: 30, maxValue: 100, leadingText: "Attack", progressBarColor: primaryColor)
                StatProgressBarView(value: 30, maxValue: 100, leadingText: "Defense", progressBarColor: primaryColor)
                StatProgressBarView(value: 30, maxValue: 100, leadingText: "Sp. Atk", progressBarColor: primaryColor)
                StatProgressBarView(value: 30, maxValue: 100, leadingText: "Sp. Def", progressBarColor: primaryColor)
                StatProgressBarView(value: 30, maxValue: 100, leadingText: "Speed", progressBarColor: primaryColor)
            }
            .font(.headline)
        }
    }
}

//#Preview {
//    StatsView()
//}

//
//  PokemonRow.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 7/23/22.
//

import SwiftUI

struct PokemonCell: View {
//    public var pokemon: Pokemon

    var body: some View {
        ZStack() {
            Color.cyan
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text("001")
                        .font(.headline)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    Text("Rowlet")
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
                .padding(.leading, 15)
                Spacer()
                Image("pokemon_rowlet")
                    .resizable()
                    .scaledToFit()
            }
        }
        .cornerRadius(20)
    }
}

struct PokemonRow_Previews: PreviewProvider {
    static var previews: some View {
        PokemonCell()
            .previewLayout(PreviewLayout.fixed(width: 170.0, height: 120.0))
    }
}

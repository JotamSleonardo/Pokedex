//
//  DetailsView.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 8/3/22.
//

import SwiftUI

struct DetailsView: View {
    let pokemon: PokemonDetailsModel

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(pokemon.description)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
                    .fixedSize(horizontal: false, vertical: true)
            }.padding(.bottom, 15.0)

            HStack {
                ForEach(pokemon.types, id: \.self) { type in
                    TypeContainer(pokeType: type)
                }
            }.padding(.bottom, 10.0)

            Text("Pokemon Data")
                .font(.headline)
                .foregroundColor(pokemon.primaryColor)
                .padding(.bottom, 15)

            HStack {
                VStack(alignment: .leading, spacing: 15.0) {
                    Text("Egg Group:")
                    Text("Gender:")
                    Text("Height:")
                    Text("Weight:")
                }
                .font(.headline)
                .padding(.trailing, 30)

                VStack(alignment: .leading, spacing: 15.0) {
                    Text(pokemon.eggGroup)
                    Text(pokemon.gender)
                    Text("\(pokemon.height) m")
                    Text("\(pokemon.weight) kg")
                }
            }
            Color.clear
        }.padding(.horizontal, 25.0)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(pokemon: PokemonDetailsModel())
    }
}

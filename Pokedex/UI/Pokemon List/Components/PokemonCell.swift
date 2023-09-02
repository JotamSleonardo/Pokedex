//
//  PokemonRow.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 7/23/22.
//

import SwiftUI
//AsyncImage(url: URL(string: pokemon.imageUrl), scale: 2)
struct PokemonCell: View {
    public var pokemon: Pokemon

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.cyan)
                .shadow(radius: 5)
            VStack(alignment: HorizontalAlignment.leading) {
                AsyncImage(url: URL(string: pokemon.imageUrl)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 100.0, height: 100.0)
                Text("POKEMON")
                    .font(.headline)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                Spacer()
            }
        }
    }
}

//struct PokemonRow_Previews: PreviewProvider {
//    static var previews: some View {
//        PokemonCell(pokemon: pokemon)
//            .previewLayout(PreviewLayout.fixed(width: 170.0, height: 120.0))
//    }
//}

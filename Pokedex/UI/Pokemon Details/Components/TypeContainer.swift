//
//  TypeContainer.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 7/24/22.
//

import SwiftUI

struct TypeContainer: View {
    var pokeType: PokeType

    var body: some View {
        HStack(spacing: 5.0) {
            pokeType.image
                .resizable()
                .scaledToFit()
                .frame(width: 15.0, height: 15.0)
            Text(pokeType.rawValue)
                .foregroundColor(Color.white)
                .font(Font.subheadline)
                .fontWeight(Font.Weight.heavy)
                .textCase(.uppercase)
        }
        .padding(.horizontal, 8.0)
        .padding(.vertical, 5)
        .background(pokeType.color)
        .cornerRadius(8.0)
    }
}

struct TypeContainer_Previews: PreviewProvider {
    static var previews: some View {
        TypeContainer(pokeType: .dragon)
    }
}

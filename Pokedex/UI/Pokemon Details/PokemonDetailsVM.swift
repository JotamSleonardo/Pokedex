//
//  PokemonDetailsVM.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 7/27/22.
//

import Foundation
import Combine
import SwiftUI

final class PokemonDetailsVM: ObservableObject {
    @Published var pokemon: PokemonDTO
    
    @Published var tabBarIndex: Int = 0

    var pokemonBinding: Binding<PokemonDTO> {
        Binding(get: { self.pokemon },
                set: { self.pokemon = $0 })
    }

    let container: DIContainer
    
    init(pokemon: PokemonDTO, container: DIContainer) {
        self.pokemon = pokemon
        self.container = container
    }

    public func getPokemonDescription() {
        container
            .services
            .pokemonDetailsService
            .getPokemonDescription(pokemon: pokemonBinding)
    }
}

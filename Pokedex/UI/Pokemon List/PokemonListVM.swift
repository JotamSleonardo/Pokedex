//
//  PokemonListVM.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 8/6/22.
//

import Foundation
import SwiftUI
import Combine

extension PokemonList {
    class ViewModel: ObservableObject {
        @Published var pokemons: Loadable<[Pokemon]>
        let container: DIContainer
        
        var pokemonsBinding: Binding<Loadable<[Pokemon]>> {
            Binding(get: { self.pokemons },
                    set: { self.pokemons = $0 })
        }
        
        init (container: DIContainer, pokemons: Loadable<[Pokemon]> = .notRequested) {
            self.container = container
            _pokemons = .init(initialValue: pokemons)
        }

        public func getPokemonList() {
            container
                .services
                .pokemonListService
                .load(pokemons: pokemonsBinding)
        }
    }
    
}

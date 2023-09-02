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
        private let pokemonListService = PokemonListService()
        
        var pokemonsBinding: Binding<Loadable<[Pokemon]>> {
            Binding(get: { self.pokemons },
                    set: { self.pokemons = $0 })
        }
        
        init (pokemons: Loadable<[Pokemon]> = .notRequested) {
            _pokemons = .init(initialValue: pokemons)
        }

        public func getPokemonList() {
            pokemonListService.load(pokemons: pokemonsBinding)
        }
    }
    
}

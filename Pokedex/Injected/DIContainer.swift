//
//  DIContainer.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 9/2/23.
//

import Foundation
import Combine


struct DIContainer {
    
    let services: Services
    
    init(services: Services) {
        self.services = services
    }
}

extension DIContainer {
    struct Services {
        let pokemonListService: PokemonListService
        let pokemonDetailsService: PokemonDetailsService
        
        init(pokemonListService: PokemonListService,
             pokemonDetailsService: PokemonDetailsService) {
            self.pokemonListService = pokemonListService
            self.pokemonDetailsService = pokemonDetailsService
        }
    }
}

//
//  PokemonListService.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 7/13/23.
//

import Foundation
import Combine
import SwiftUI

protocol PokemonListType {
    
    func load(pokemons: LoadableSubject<[Pokemon]>)
}

class PokemonListService: PokemonListType {
    let webRepository: PokemonListWebRepository
    
    init(webRepository: PokemonListWebRepository) {
        self.webRepository = webRepository
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    func load(pokemons: LoadableSubject<[Pokemon]>) {
        pokemons.wrappedValue = .isLoading
        
        self.webRepository
            .loadPokemons()
            .sink { (completion) in
                /// TODO: Handle error
                print(completion)
            } receiveValue: { (fetchedPokemons) in
                pokemons.wrappedValue = .loaded(fetchedPokemons.pokemons)
            }
            .store(in: &cancellables)

    }
    
    func getPokemonType(pokemon: Pokemon) {
        
    }
}

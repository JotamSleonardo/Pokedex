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
    
    func load(pokemons: LoadableSubject<[PokemonDTO]>)
}

public class PokemonListService: PokemonListType {
    let webRepository: PokemonListWebRepository

    private var cancellables = Set<AnyCancellable>()

    init(webRepository: PokemonListWebRepository) {
        self.webRepository = webRepository
    }
    
    func load(pokemons: LoadableSubject<[PokemonDTO]>) {
        pokemons.wrappedValue = .isLoading

        self.webRepository
            .loadPokemons()
            .sink(
                receiveCompletion: { (error) in
                    // TODO: Handle error
                },
                receiveValue: { (fetchedPokemons) in
                    self.getPokemonDetails(
                        pokemons: fetchedPokemons.pokemons,
                        bindingPokemons: pokemons
                    )
                }
            )
            .store(in: &cancellables)

    }
    
    private func getPokemonDetails(pokemons: [Pokemon], bindingPokemons: LoadableSubject<[PokemonDTO]>) {
        var completedRequests = 0
        var updatedPokemons: [PokemonDTO] = []

        pokemons.forEach { pokemon in
            self.webRepository
                .getPokemontType(pokemonID: pokemon.id.description)
                .sink(
                    receiveCompletion: { (completion) in
                        completedRequests += 1
                        if completedRequests == pokemons.count {
                            bindingPokemons.wrappedValue = .loaded(updatedPokemons)
                        }
                    },
                    receiveValue: { (fetchedPokemon) in
                        updatedPokemons.append(PokemonDTO(pokemon: fetchedPokemon))
                    }
                )
                .store(in: &cancellables)
        }
    }
}

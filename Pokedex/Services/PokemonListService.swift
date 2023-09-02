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
    private var cancellables = Set<AnyCancellable>()
    
    func load(pokemons: LoadableSubject<[Pokemon]>) {
        pokemons.wrappedValue = .isLoading
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = .shared
        
        let pokemonWebRepository = PokemonListWebRepository(
            session: URLSession(configuration: configuration),
            baseURL: "https://pokeapi.co/api/v2/"
        )

        
        pokemonWebRepository
            .loadPokemons()
            .sink { (subscriptionCompletion) in
                print(subscriptionCompletion)
            } receiveValue: { (fetchedPokemons) in
                pokemons.wrappedValue = .loaded(fetchedPokemons.pokemons)
            }
            .store(in: &cancellables)

    }
}

//
//  PokemonListService.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 7/13/23.
//

import Foundation
import Combine
import Astral
import BFAstral
import BrightFutures
import SwiftUI

protocol PokemonListType {
    func refreshPokemonList() -> AnyPublisher<[Pokemon], Error>
    
    func load(pokemons: LoadableSubject<[Pokemon]>)
}

struct PokemonListService: PokemonListType {
    func load(pokemons: LoadableSubject<[Pokemon]>) {
        let dispatcher: BFDispatcher = BFDispatcher(strategy: JSONStrategy(), isDebugMode: true)
        let decoder: JSONDecoder = JSONDecoder()
        let request: PokemonListRequest = PokemonListRequest()

        dispatcher.response(of: request)
            .onSuccess { (response) -> Void in
                do {
                    let data = try decoder.decode(Result.self, from: response.data)
                    DispatchQueue.main.async {
                        pokemons.wrappedValue = .loaded(data.pokemons)
                    }
                } catch let error {
                    print(error)
                }
            }
            .onFailure { error -> Void in
                print(error)
            }
    }
    
    func refreshPokemonList() -> AnyPublisher<[Pokemon], Error> {
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
        
        let samp = pokemonWebRepository.loadPokemons()
        
        return samp
    }
}

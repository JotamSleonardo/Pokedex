//
//  AppEnvironment.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 7/13/23.
//

import Foundation

struct AppEnvironment {
    let container: DIContainer
    
    static func setUpEnvironment() -> AppEnvironment {
        let session = configuredURLSession()
        let pokemonListWebRepository = PokemonListWebRepository(
            session: session,
            baseURL: K.pokeApiBaseURL
        )
        let pokemonDetailsWebRepository = PokemonDetailsWebRepository(
            session: session,
            baseURL: K.pokeApiBaseURL
        )

        let pokemonListService: PokemonListService = PokemonListService(webRepository: pokemonListWebRepository)
        let pokemonDetailsService: PokemonDetailsService = PokemonDetailsService(webRepository: pokemonDetailsWebRepository)

        let services = DIContainer.Services(
            pokemonListService: pokemonListService,
            pokemonDetailsService: pokemonDetailsService
        )
        let diContainer = DIContainer(services: services)
        
        return AppEnvironment(container: diContainer)
    }
    
    private static func configuredURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = .shared

        return URLSession(configuration: configuration)
    }
}

//
//  PokemonListRepository.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 7/13/23.
//

import Foundation
import Combine

protocol PokemonListRepositoryType: WebRepository {
    
    func loadPokemons() -> AnyPublisher<Result, Error>
    
    func getPokemontType(pokemonID: String) -> AnyPublisher<Pokemon, Error>
    
}

struct PokemonListWebRepository: PokemonListRepositoryType {
    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func loadPokemons() -> AnyPublisher<Result, Error> {
        return self.call(endpoint: ListAPI.allPokemons)
    }
    
    func getPokemontType(pokemonID: String) -> AnyPublisher<Pokemon, Error> {
        return self.call(endpoint: ListAPI.pokemonType(pokemonID))
    }
}

extension PokemonListWebRepository {
    enum ListAPI {
        case allPokemons
        case pokemonType(String)
    }
}

extension PokemonListWebRepository.ListAPI: APICall {
    var path: String {
        switch self {
            case .allPokemons:
                return K.pokemon
            case let .pokemonType(pokeId):
                return "\(K.pokemon)/\(pokeId)"
        }
    }
    
    var method: String {
        return "GET"
    }
    
    var headers: [String: String]? {
        return ["Accept": "application/json"]
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
            case .allPokemons:
                return [URLQueryItem(name: "limit", value: "100")]
            case .pokemonType(_):
                return nil
        }
    }
    
    func body() throws -> Data? {
        return nil
    }
}

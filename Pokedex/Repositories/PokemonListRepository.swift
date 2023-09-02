//
//  PokemonListRepository.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 7/13/23.
//

import Foundation
import Combine

protocol PokemonListRepositoryType: WebRepository {
    
    func loadPokemons() -> AnyPublisher<[Pokemon], Error>
    
}

struct PokemonListWebRepository: PokemonListRepositoryType {
    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func loadPokemons() -> AnyPublisher<[Pokemon], Error> {
        return self.call(endpoint: API.allPokemons)
    }
}

extension PokemonListWebRepository {
    enum API {
        case allPokemons
    }
}

extension PokemonListWebRepository.API: APICall {
    var path: String {
        return "pokemon"
    }
    
    var method: String {
        return "GET"
    }
    
    var headers: [String: String]? {
        return ["Accept": "application/json"]
    }
    
    func body() throws -> Data? {
        return nil
    }
}

//
//  PokemonDetailsRepository.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 3/26/24.
//

import Foundation
import Combine

protocol PokemonDetailsRepositoryType: WebRepository {

    func getPokemonDescription(pokemonID: String) -> AnyPublisher<PokemonSpecies, Error>

    func getPokemonEggGroup(pokemonID: String) -> AnyPublisher<EggGroup, Error>

    func getPokemonGender(pokemonID: String) -> AnyPublisher<Gender, Error>

}

struct PokemonDetailsWebRepository: PokemonDetailsRepositoryType {
    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")

    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }

    func getPokemonDescription(pokemonID: String) -> AnyPublisher<PokemonSpecies, Error> {
        return call(endpoint: DetailsAPI.pokemonDescription(pokemonID))
    }


    func getPokemonEggGroup(pokemonID: String) -> AnyPublisher<EggGroup, Error> {
        return call(endpoint: DetailsAPI.pokemonEggGroup(pokemonID))
    }

    func getPokemonGender(pokemonID: String) -> AnyPublisher<Gender, Error> {
        return call(endpoint: DetailsAPI.pokemonGender(pokemonID))
    }
}

extension PokemonDetailsWebRepository {
    enum DetailsAPI {
        case pokemonDescription(String)
        case pokemonEggGroup(String)
        case pokemonGender(String)
    }
}

extension PokemonDetailsWebRepository.DetailsAPI: APICall {
    var path: String {
        switch self {
            case let .pokemonDescription(pokeId):
                return "\(K.pokemonSpecies)/\(pokeId)"
            case let .pokemonEggGroup(pokeId):
                return "\(K.pokemonEgg)/\(pokeId)"
            case let .pokemonGender(pokeId):
                return "\(K.pokemonGender)/\(pokeId)"
        }
    }

    var method: String {
        return "GET"
    }

    var headers: [String: String]? {
        return ["Accept": "application/json"]
    }

    var parameters: [URLQueryItem]? {
        return nil
    }

    func body() throws -> Data? {
        return nil
    }


}

//
//  PokemonSpeciesRequest.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 7/26/22.
//

import Foundation
import BrightFutures
import Astral

public struct PokemonSpeciesRequest: Request {

    // MARK: - Stored Properties
    public var parameters: Parameters = .none

    public let configuration: RequestConfiguration = PokeAPIConfiguration()

    public let method: HTTPMethod = HTTPMethod.get

    public let headers: Set<Header> = []

    public var cachePolicy: URLRequest.CachePolicy?

    public let id: String

    // MARK: - Computed Properties
    public var pathComponents: [String] {
        return [
            K.pokemonSpecies,
            "\(self.id)"
        ]
    }

    public init(id: String) {
        self.id = id
    }
}

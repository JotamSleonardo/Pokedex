//
//  PokemonListRequest.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 7/23/22.
//

import Foundation
import BrightFutures
import Astral

public struct PokemonListRequest: Request {
    // MARK: - Stored Properties
    public var parameters: Parameters = .dict(["limit" : "42"])

    public let configuration: RequestConfiguration = PokeAPIConfiguration()

    public let method: HTTPMethod = HTTPMethod.get

    public let headers: Set<Header> = []

    public var cachePolicy: URLRequest.CachePolicy?

    // MARK: - Computed Properties
    public var pathComponents: [String] {
        return [K.pokemon]
    }
}

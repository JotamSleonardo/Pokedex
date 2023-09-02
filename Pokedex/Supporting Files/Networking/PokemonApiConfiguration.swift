//
//  PokemonApiConfiguration.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 7/23/22.
//

import Foundation
import BrightFutures
import Astral

public struct PokeAPIConfiguration: RequestConfiguration {

    // MARK: - Stored Properties
    public let scheme: URLScheme = URLScheme.http

    public let host: String = "pokeapi.co"

    public let basePathComponents: [String] = ["api", "v2"]

    public let baseHeaders: Set<Header> = [
        Header(key: Header.Key.contentType, value: Header.Value.mediaType(MediaType.applicationJSON))
    ]
}

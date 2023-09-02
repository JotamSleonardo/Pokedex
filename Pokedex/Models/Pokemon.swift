//
//  Pokemon.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 7/23/22.
//

import Foundation

public struct Result: Codable {
    public let pokemons: [Pokemon]

    private enum CodingKeys: String, CodingKey {
        case pokemons = "results"
    }
}

public struct Pokemon: Codable, Identifiable {
    // MARK: - Stored Properties
    public let name: String
    public let url: String
    public let id: Int
    public let height: Int
    public let weight: Int
    public var description: String = ""
    public var types: [TypeSlot] = []

    // MARK: - Initializers
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.height = try container.decodeIfPresent(Int.self, forKey: .height) ?? 0
        self.weight = try container.decodeIfPresent(Int.self, forKey: .weight) ?? 0
        self.url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
        self.types = try container.decodeIfPresent([TypeSlot].self, forKey: .types) ?? []
        if let id = try container.decodeIfPresent(Int.self, forKey: .id) {
            self.id = id
        } else if let url = URL(string: self.url), let id = Int(url.lastPathComponent) {
            self.id = id
        } else {
            self.id = -1
        }
    }
    
    public var pokemonID: String {
        var pokeID: String = ""
        if self.id < 10 {
            pokeID = "00\(self.id)"
        } else if self.id < 100 {
            pokeID = "0\(self.id)"
        } else {
            pokeID = self.id.description
        }
        return pokeID
    }

    public var imageUrl: String {
        return K.pokemonImageURL.replacingOccurrences(
            of: "$0",
            with: pokemonID
        )
    }

    private enum CodingKeys: String, CodingKey {
        case name
        case height
        case weight
        case id
        case url
        case types
    }
}

public struct TypeSlot: Codable, Identifiable {
    public var id = UUID()
    public let type: PokemonType

    private enum CodingKeys: String, CodingKey {
        case type
    }
}

public struct PokemonType: Codable {
    public let name: String
}

public struct PokemonSpecies: Decodable {
    // MARK: - Stored Properties
    let flavorText: [PokemonDescription]
    let evolutionChain: EvolutionChain

    // MARK: - PokemonDetials Enums
    public enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text_entries"
        case evolutionChain = "evolution_chain"
    }
}

public struct Language: Decodable {

    // MARK: - Stored Properties
    let name: String
}

public struct Version: Decodable {

    // MARK: - Stored Properties
    let name: String
}

public struct PokemonDescription: Decodable {

    // MARK: - Stored Properties
    let description: String
    let language: Language
    let version: Version

    // MARK: - PokemonDescription Enums
    public enum CodingKeys: String, CodingKey {
        case description = "flavor_text"
        case language
        case version
    }
}

public struct EvolutionChain: Decodable {
    // MARK: - Stored Properties
    let url: String
}



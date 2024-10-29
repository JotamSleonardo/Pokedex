//
//  PokemonDetailsModel.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 7/26/22.
//

import Foundation
import SwiftUI

public final class PokemonDTO: Identifiable {
    // MARK: - Stored Properties
    public var id: String = ""
    public var imageId: String = ""
    public var name: String = ""
    public var height: Int = 0
    public var weight: Int = 0
    public var gender: String = ""
    public var eggGroup: String = ""
    public var types: [PokeType] = []
    public var stats: [String] = []
    public var description: String = ""
    public var evolutionId: Int = 0
    public var evolution: [String] = []
    
    init(pokemon: Pokemon) {
        self.id = pokemon.id.description
        self.imageId = String(format: "%03d", pokemon.id)
        self.name = pokemon.name
        self.height = pokemon.height
        self.weight = pokemon.weight
        self.types = pokemon.types.map { PokeType(type: $0.type.name)}
    }

    public func update(with species: PokemonSpecies) -> PokemonDTO {
        self.description = species
            .flavorText
            .first(
                where: { ($0.version.name == "alpha-sapphire" && $0.language.name == "en") }
            )?.description ?? ""

        return self
    }
}

extension PokemonDTO {
    public var imageUrl: String {
        return K.pokemonImageURL.replacingOccurrences(
            of: "$0",
            with: self.imageId
        )
    }

    public var primaryColor: Color {
        guard let pokeType = self.types.first else { return Color.clear }
        return pokeType.color
    }
}

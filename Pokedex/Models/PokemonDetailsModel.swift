//
//  PokemonDetailsModel.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 7/26/22.
//

import Foundation
import SwiftUI

public final class PokemonDetailsModel {
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

    //MARK: Computed Properties
    public var imageUrl: URL {
        guard
            let url = URL(string: K.pokemonHQImageURL.replacingOccurrences(of: "$0", with: "\(self.imageId)"))
        else {
            return URL(string: "")!
        }

        return url
    }

    public var primaryColor: Color {
        guard let pokeType = self.types.first else { return Color.clear }
        return pokeType.color
    }
}

public enum PokeType: String {
    case normal
    case fire
    case water
    case grass
    case electric
    case ice
    case fighting
    case poison
    case ground
    case flying
    case psychic
    case bug
    case rock
    case ghost
    case dark
    case dragon
    case steel
    case fairy

    public init(type: String) {
        switch type {
            case "normal":
                self = .normal
            case "fire":
                self = .fire
            case "water":
                self = .water
            case "grass":
                self = .grass
            case "electric":
                self = .electric
            case "ice":
                self = .ice
            case "fighting":
                self = .fighting
            case "poison":
                self = .poison
            case "ground":
                self = .ground
            case "flying":
                self = .flying
            case "psychic":
                self = .psychic
            case "bug":
                self = .bug
            case "rock":
                self = .rock
            case "ghost":
                self = .ghost
            case "dark":
                self = .dark
            case "dragon":
                self = .dragon
            case "steel":
                self = .steel
            case "fairy":
                self = .fairy
            default:
                self = .normal
        }
    }

    public var image: Image {
        return Image("type_\(self.rawValue)")
    }

    public var color: Color {
        switch self {
            case .normal:
                return Color(hex: "A8A77A")
            case .fire:
                return Color(hex: "EE8130")
            case .water:
                return Color(hex: "6390F0")
            case .grass:
                return Color(hex: "7AC74C")
            case .electric:
                return Color(hex: "F7D02C")
            case .ice:
                return Color(hex: "96D9D6")
            case .fighting:
                return Color(hex: "C22E28")
            case .poison:
                return Color(hex: "A33EA1")
            case .ground:
                return Color(hex: "E2BF65")
            case .flying:
                return Color(hex: "A98FF3")
            case .psychic:
                return Color(hex: "F95587")
            case .bug:
                return Color(hex: "A6B91A")
            case .rock:
                return Color(hex: "B6A136")
            case .ghost:
                return Color(hex: "735797")
            case .dark:
                return Color(hex: "705746")
            case .dragon:
                return Color(hex: "6F35FC")
            case .steel:
                return Color(hex: "B7B7CE")
            case .fairy:
                return Color(hex: "D685AD")
        }
    }
}


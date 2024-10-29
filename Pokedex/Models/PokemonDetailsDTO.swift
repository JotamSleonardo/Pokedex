//
//  PokemonDetailsDTO.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 4/4/24.
//

import Foundation

public struct PokemonDetailsDTO: Decodable {
    let name: String
    let id: String
    let imageUrl: String
    let xDescription: String
    let yDescription: String
    let height: String
    let category: String
    let weight: String
    let typeOfPokemon: [String]
    let weaknesses: [String]
    let evolutions: [String]
    let abilities: [String]
    let hp: Int
    let attack: Int
    let defense: Int
    let specialAttack: Int
    let specialDefense: Int
    let speed: Int
    let total: Int
    let malePercentage: String
    let femalePercentage: String
    let genderless: Int
    let cycles: String
    let eggGroups: String
    let evolvedFrom: String
    let reason: String
    let baseExp: String

    enum CodingKeys: String, CodingKey {
        case name
        case id
        case imageUrl = "imageurl"
        case xDescription = "xdescription"
        case yDescription = "ydescription"
        case height
        case category
        case weight
        case typeOfPokemon = "typeofpokemon"
        case weaknesses
        case evolutions
        case abilities
        case hp
        case attack
        case defense
        case specialAttack = "special_attack"
        case specialDefense = "special_defense"
        case speed
        case total
        case malePercentage = "male_percentage"
        case femalePercentage = "female_percentage"
        case genderless
        case cycles
        case eggGroups = "egg_groups"
        case evolvedFrom = "evolvedfrom"
        case reason
        case baseExp = "base_exp"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(String.self, forKey: .id)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
        xDescription = try container.decode(String.self, forKey: .xDescription)
        yDescription = try container.decode(String.self, forKey: .yDescription)
        height = try container.decode(String.self, forKey: .height)
        category = try container.decode(String.self, forKey: .category)
        weight = try container.decode(String.self, forKey: .weight)
        typeOfPokemon = try container.decode([String].self, forKey: .typeOfPokemon)
        weaknesses = try container.decode([String].self, forKey: .weaknesses)
        evolutions = try container.decode([String].self, forKey: .evolutions)
        abilities = try container.decode([String].self, forKey: .abilities)
        hp = try container.decode(Int.self, forKey: .hp)
        attack = try container.decode(Int.self, forKey: .attack)
        defense = try container.decode(Int.self, forKey: .defense)
        specialAttack = try container.decode(Int.self, forKey: .specialAttack)
        specialDefense = try container.decode(Int.self, forKey: .specialDefense)
        speed = try container.decode(Int.self, forKey: .speed)
        total = try container.decode(Int.self, forKey: .total)
        malePercentage = try container.decodeIfPresent(String.self, forKey: .malePercentage) ?? ""
        femalePercentage = try container.decodeIfPresent(String.self, forKey: .femalePercentage) ?? ""
        genderless = try container.decode(Int.self, forKey: .genderless)
        cycles = try container.decode(String.self, forKey: .cycles)
        eggGroups = try container.decode(String.self, forKey: .eggGroups)
        evolvedFrom = try container.decode(String.self, forKey: .evolvedFrom)
        reason = try container.decode(String.self, forKey: .reason)
        baseExp = try container.decode(String.self, forKey: .baseExp)
    }
}

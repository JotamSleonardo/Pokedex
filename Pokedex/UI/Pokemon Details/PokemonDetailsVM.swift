//
//  PokemonDetailsVM.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 7/27/22.
//

import Foundation

final class PokemonDetailsVM: ObservableObject {
    enum State {
        case idle
        case loading
        case failed(Error)
        case loaded(PokemonDetailsModel)
    }

    @Published private(set) var state: State = State.idle

    @Published var tabBarIndex: Int = 0

    private(set) var pokemon: PokemonDetailsModel = PokemonDetailsModel()

    private let service: PokemonDetailsService = PokemonDetailsService()

    private let id: String

    init(id: String) {
        self.id = id
    }

    public func loadDetails() {
        self.state = State.loading
        self.service.getPokemonDetails(with: self.id)
            .onSuccess { pokemon in
                self.pokemon.name = pokemon.name
                if pokemon.id < 10 {
                    self.pokemon.imageId = "00\(pokemon.id)"
                } else if pokemon.id < 100 {
                    self.pokemon.imageId = "0\(pokemon.id)"
                } else {
                    self.pokemon.imageId = pokemon.id.description
                }
                self.pokemon.id = pokemon.id.description
                self.pokemon.height = pokemon.height
                self.pokemon.weight = pokemon.weight
                self.pokemon.types = pokemon.types.map { PokeType(type: $0.type.name) }
                self.getDescription()
            }
            .onFailure { error in
                self.state = State.failed(error)
            }
    }

    private func getDescription() {
        self.service.getPokemonDescription(with: self.pokemon.id)
            .onSuccess { pokemon in
                guard
                    let flavorText = pokemon.flavorText
                        .first(where: { $0.language.name == "en" && $0.version.name == "ruby"})
                else {
                    return
                }
                self.pokemon.description = flavorText.description
                    .components(separatedBy: .newlines).joined()
                self.getPokemonGender()
            }
            .onFailure { error in
                self.state = State.failed(error)
            }
    }

    private func getPokemonGender() {
        self.service.getPokemonGender(with: self.pokemon.id)
            .onComplete { response in
                if let pokemon = response.result.value {
                    self.pokemon.gender = pokemon.name.capitalizingFirstLetter()
                } else {
                    self.pokemon.gender = "Genderless"
                }
                self.getPokemonEggGroups()
            }
    }

    private func getPokemonEggGroups() {
        self.service.getPokemonEggGroup(with: self.pokemon.id)
            .onComplete { response in
                if let pokemon = response.result.value {
                    self.pokemon.eggGroup = pokemon.name.capitalizingFirstLetter()
                } else {
                    self.pokemon.eggGroup = "Monster"
                }
                self.state = State.loaded(self.pokemon)
            }
    }
}

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
    }

    private func getDescription() {
    }

    private func getPokemonGender() {
    }

    private func getPokemonEggGroups() {
    }
}

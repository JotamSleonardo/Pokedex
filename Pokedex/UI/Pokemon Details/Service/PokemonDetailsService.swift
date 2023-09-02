//
//  PokemonDetailsService.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 7/25/22.
//

import Foundation
import BrightFutures
import BFAstral
import Astral
import SwiftUI

public struct PokemonDetailsService {
    // MARK: - Stored Properties
    private let decoder: JSONDecoder = JSONDecoder()

    // MARK: - Computed Properties
    private let dispatcher: BFDispatcher = BFDispatcher(
        strategy: JSONStrategy(),
        isDebugMode: true
    )
    private let queue: DispatchQueue = DispatchQueue(
        label: K.pokemonApi,
        qos: DispatchQoS.utility,
        attributes: [DispatchQueue.Attributes.concurrent]
    )

    // MARK: - Instance Methods
    public func getPokemonDetails(with id: String) -> Future<Pokemon, NetworkingError> {
        let request: PokemonDetailsRequest = PokemonDetailsRequest(id: id)

        return self.dispatcher.response(of: request)
            .map(queue.context) { (response: Response) -> Pokemon in
                do {
                    return try self.decoder.decode(Pokemon.self, from: response.data)
                } catch let error {
                    fatalError(error.localizedDescription)
                }
            }
    }

    public func getPokemonDescription(with id: String) -> Future<PokemonSpecies, NetworkingError> {
        let request: PokemonSpeciesRequest = PokemonSpeciesRequest(id: id)

        return self.dispatcher.response(of: request)
            .map(queue.context) { (response: Response) -> PokemonSpecies in
                do {
                    return try self.decoder.decode(PokemonSpecies.self, from: response.data)
                } catch let error {
                    fatalError(error.localizedDescription)
                }
            }
    }

    public func getPokemonGender(with id: String) -> Future<Pokemon, NetworkingError> {
        let request: BaseRequest = BaseRequest(pathComponents: [K.pokemonGender, id])

        return self.dispatcher.response(of: request)
            .map(queue.context) { (response: Response) -> Pokemon in
                do {
                    return try self.decoder.decode(Pokemon.self, from: response.data)
                } catch let error {
                    fatalError(error.localizedDescription)
                }
            }
    }

    public func getPokemonEggGroup(with id: String) -> Future<Pokemon, NetworkingError> {
        let request: BaseRequest = BaseRequest(pathComponents: [K.pokemonEgg, id])

        return self.dispatcher.response(of: request)
            .map(queue.context) { (response: Response) -> Pokemon in
                do {
                    return try self.decoder.decode(Pokemon.self, from: response.data)
                } catch let error {
                    fatalError(error.localizedDescription)
                }
            }
    }
}

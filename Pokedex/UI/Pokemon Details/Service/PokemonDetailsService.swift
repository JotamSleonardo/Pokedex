//
//  PokemonDetailsService.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 7/25/22.
//

import Foundation
import SwiftUI
import Combine

protocol PokemonDetailsType {

    func getPokemonDescription(pokemon: Binding<PokemonDTO>)

}

public class PokemonDetailsService: PokemonDetailsType {
    let webRepository: PokemonDetailsWebRepository

    private var cancellables = Set<AnyCancellable>()

    init(webRepository: PokemonDetailsWebRepository) {
        self.webRepository = webRepository
    }

    func getPokemonDescription(pokemon: Binding<PokemonDTO>) {
        self.webRepository
            .getPokemonDescription(pokemonID: pokemon.id)
            .sink(
                receiveCompletion: { (completion) in
                    // Handle errors
                },
                receiveValue: { (species) in
                    let updatedPokemon = pokemon.wrappedValue.update(with: species)
                    self.getPokemonEggGroup(updatedPokemon: updatedPokemon, pokemon: pokemon)
                }
            )
            .store(in: &cancellables)

        guard 
            let path = Bundle.main.path(forResource: "pokemons", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path))
        else {
            return
        }

        if let path = Bundle.main.path(forResource: "pokemons", ofType: "json"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            do {
                let decoder = JSONDecoder()
                let pokemonList = try decoder.decode([PokemonDetailsDTO].self, from: data)

                for pokemon in pokemonList {
                    print("Name: \(pokemon.name)")
                    print("ID: \(pokemon.id)")
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
    }

    private func getPokemonEggGroup(updatedPokemon: PokemonDTO, pokemon: Binding<PokemonDTO>) {
        self.webRepository
            .getPokemonEggGroup(pokemonID: pokemon.id)
            .sink(
                receiveCompletion: { (completion) in
                    switch completion {
                        case .finished:
                            // Handle completion if necessary
                            break
                        case .failure(let error):
                            // Handle error
                            print("Error: \(error)")
                        }
                },
                receiveValue: { (eggGroup) in
                    updatedPokemon.eggGroup = eggGroup.name
                    pokemon.wrappedValue = updatedPokemon
                }
            )
            .store(in: &cancellables)
    }

    // MARK: - Instance Methods
//    public func getPokemonDetails(with id: String) -> Future<Pokemon, NetworkingError> {
//        let request: PokemonDetailsRequest = PokemonDetailsRequest(id: id)
//
//        return self.dispatcher.response(of: request)
//            .map(queue.context) { (response: Response) -> Pokemon in
//                do {
//                    return try self.decoder.decode(Pokemon.self, from: response.data)
//                } catch let error {
//                    fatalError(error.localizedDescription)
//                }
//            }
//    }
//
//    public func getPokemonDescription(with id: String) -> Future<PokemonSpecies, NetworkingError> {
//        let request: PokemonSpeciesRequest = PokemonSpeciesRequest(id: id)
//
//        return self.dispatcher.response(of: request)
//            .map(queue.context) { (response: Response) -> PokemonSpecies in
//                do {
//                    return try self.decoder.decode(PokemonSpecies.self, from: response.data)
//                } catch let error {
//                    fatalError(error.localizedDescription)
//                }
//            }
//    }
//
//    public func getPokemonGender(with id: String) -> Future<Pokemon, NetworkingError> {
//        let request: BaseRequest = BaseRequest(pathComponents: [K.pokemonGender, id])
//
//        return self.dispatcher.response(of: request)
//            .map(queue.context) { (response: Response) -> Pokemon in
//                do {
//                    return try self.decoder.decode(Pokemon.self, from: response.data)
//                } catch let error {
//                    fatalError(error.localizedDescription)
//                }
//            }
//    }
//
//    public func getPokemonEggGroup(with id: String) -> Future<Pokemon, NetworkingError> {
//        let request: BaseRequest = BaseRequest(pathComponents: [K.pokemonEgg, id])
//
//        return self.dispatcher.response(of: request)
//            .map(queue.context) { (response: Response) -> Pokemon in
//                do {
//                    return try self.decoder.decode(Pokemon.self, from: response.data)
//                } catch let error {
//                    fatalError(error.localizedDescription)
//                }
//            }
//    }
}

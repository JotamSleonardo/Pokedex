//
//  PokemonListView.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 7/23/22.
//

import SwiftUI

struct PokemonList: View {
    @ObservedObject private(set) var viewModel: ViewModel

    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationView {
            self.content
        }
    }
    
    @ViewBuilder private var content: some View {
        switch self.viewModel.pokemons {
            case .notRequested:
                Color.clear.onAppear {
                    self.viewModel.getPokemonList()
                }
            case .isLoading:
                VStack {
                    ProgressView()
                        .scaleEffect(2.0)
                        .frame(width: 50.0, height: 50.0)
                    Text("Loading...")
                }
            case .loaded(let pokemons) :
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(pokemons) { pokemon in
                            NavigationLink(
                                destination: PokemonDetailsView(viewModel: .init(
                                    pokemon: pokemon,
                                    container: self.viewModel.container
                                ))
                            ) {
                                PokemonCell(pokemon: pokemon)
                                    .frame(height: 150.0)
                            }
                        }
                    }
                    .padding()
                    .navigationTitle("Pokemons")
                }
            case .failed(let error):
                ErrorView(error: error, retryAction: {
                    self.viewModel.getPokemonList()
                })
        }
    }
}

// TODO: Handle Previews
//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        PokemonList(viewModel: .init())
//    }
//}

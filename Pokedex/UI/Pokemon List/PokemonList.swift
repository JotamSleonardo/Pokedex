//
//  PokemonListView.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 7/23/22.
//

import SwiftUI
import QGrid

struct PokemonList: View {
    @ObservedObject private var viewModel: ViewModel = ViewModel()

    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
        NavigationView {
            self.content
        }
    }
    
    @ViewBuilder private var content: some View {
        switch self.viewModel.pokemons {
            case .notRequested:
                Text("").onAppear {
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
                            NavigationLink(destination: PokemonDetails(id: "\(pokemon.id)")) {
                                PokemonCell()
                                    .frame(height: 120.0)
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

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
    }
}

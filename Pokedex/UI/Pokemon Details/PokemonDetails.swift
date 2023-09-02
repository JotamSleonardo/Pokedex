//
//  PokemonDetails.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 7/23/22.
//

import SwiftUI

struct PokemonDetails: View {
    @ObservedObject private var viewModel: PokemonDetailsVM

    init(id: String) {
        self.viewModel = PokemonDetailsVM(id: id)
    }

    var body: some View {
        switch viewModel.state {
            case .idle:
                Color.clear
                    .onAppear {
                        viewModel.loadDetails()
                    }
            case .loading:
                ProgressView()
                    .edgesIgnoringSafeArea(Edge.Set.all)
            case .failed(let error):
                Text("\(error.localizedDescription)")
            case .loaded(let pokemon):
                let primaryColor: Color = viewModel.pokemon.primaryColor
                ZStack(alignment: .top) {
                    primaryColor
                        .edgesIgnoringSafeArea(Edge.Set.all)
                    VStack {
                        VStack {
                            TabBarView(selectedColor: primaryColor, selectedIndex: $viewModel.tabBarIndex)
                                .padding(.horizontal, 15)
                                .padding(.bottom, 20)

                            switch viewModel.tabBarIndex {
                                case 0:
                                    DetailsView(pokemon: viewModel.pokemon)
                                case 1:
                                    Text("hindor")
                                case 2:
                                    Text("pakshet")
                                default:
                                    EmptyView()
                            }
                            Color.clear
                        }
                        .padding(.top, 30.0)
                        .background(Color.white)
                        .cornerRadius(
                            radius: 25.0,
                            corners: [
                                UIRectCorner.topLeft,
                                UIRectCorner.topRight
                            ]
                        )
                        .edgesIgnoringSafeArea(Edge.Set.bottom)
                    }
                    .padding(.top, 270.0)

                    VStack(alignment: .leading) {
                        Text("#\(self.viewModel.pokemon.imageId)")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text(viewModel.pokemon.name)
                            .font(.title)
                            .fontWeight(.heavy)
                            .textCase(.uppercase)
                            .foregroundColor(.white)

                        HStack {
                            ForEach(viewModel.pokemon.types, id: \.self) { type in
                                CircleImage(
                                    image: type.image,
                                    imageSize: CGSize(width: 20.0, height: 20.0)
                                )
                            }
                        }
                        Color.clear
                    }.padding(.leading, 50)

                    AsyncImage(url: pokemon.imageUrl) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    }
                    .frame(width: 220.0, height: 220.0)
                    .padding(.top, 50)
                }.navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct PokemonDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PokemonDetails(id: "1")
        }
    }
}

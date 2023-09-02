//
//  ContentView.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 7/23/22.
//

import SwiftUI

struct ContentView: View {
    let container: DIContainer
    
    var body: some View {
        PokemonList(viewModel: .init(container: container))
    }
}

/// TODO: Handle preview
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(container: DIContainer)
//    }
//}

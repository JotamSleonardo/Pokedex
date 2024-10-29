//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 7/23/22.
//

import SwiftUI

@main
struct PokedexApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                container: AppEnvironment
                    .setUpEnvironment()
                    .container
            )
        }
    }
}

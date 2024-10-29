//
//  SampleView.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 7/24/22.
//

import SwiftUI

struct SampleView: View {
    var body: some View {
        ZStack {
            Color.cyan
                .edgesIgnoringSafeArea(Edge.Set.all)
            HStack {

            }
            VStack {
                VStack {

                    Color.clear
                }
                .background(Color.white)
                .cornerRadius(40.0)
                .edgesIgnoringSafeArea(Edge.Set.bottom)
            }
            .padding(Edge.Set.top, 200.0)
        }
//        HStack {
//            Text("tarantado")
//            Image(systemName: "star.fill")
//        }
//        .padding()
//        .background(Color.cyan)
//        .cornerRadius(25.0)
    }
}

struct SampleView_Previews: PreviewProvider {
    static var previews: some View {
        SampleView()
    }
}

//
//  TabItem.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 8/2/22.
//

import SwiftUI

struct TabItem: View {
    let title: String
    let isSelected: Bool
    let selectedColor: Color

    var body: some View {
        Text(title)
            .font(.body)
            .fontWeight(.heavy)
            .foregroundColor(isSelected ? selectedColor : .gray)
            .frame(width: 100, height: 30, alignment: Alignment.center)
            .background(
                Color.white
                    .cornerRadius(10)
                    .shadow(radius: 5)
            )
    }
}

struct TabItem_Previews: PreviewProvider {
    static var previews: some View {
        TabItem(title: "About", isSelected: true, selectedColor: Color.gray)
    }
}

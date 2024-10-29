//
//  TabBarView.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 8/2/22.
//

import SwiftUI

struct TabBarView: View {
    let tabBarItems: [String] = ["About", "Stats", "Evolution"]
    let selectedColor: Color
    @Binding var selectedIndex: Int

    var body: some View {
        HStack {
            ForEach(tabBarItems.indices, id: \.self) { index in
                Spacer()
                Button {
                    self.selectedIndex = index
                } label: {
                    TabItem(
                        title: tabBarItems[index],
                        isSelected: selectedIndex == index,
                        selectedColor: selectedColor
                    )
                }
                Spacer()
            }
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(selectedColor: Color.cyan, selectedIndex: .constant(0))
    }
}

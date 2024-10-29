//
//  StatProgressBar.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 3/27/24.
//

import SwiftUI

struct StatProgressBarView: View {
    let value: Double
    let maxValue: Double
    let leadingText: String
    let progressBarColor: Color

    var body: some View {
        HStack {
            Text(leadingText)
                .frame(maxWidth: 70, alignment: .leading)
                .fontWeight(.bold)
                .italic()
            Text("\(Int(value))")
                .frame(maxWidth: 30)
            ProgressBar(
                value: value,
                maxValue: maxValue,
                color: progressBarColor
            ).frame(maxWidth: .infinity)
        }
    }
}

struct ProgressBar: View {
    let value: Double
    let maxValue: Double
    let color: Color

    private var progress: Double {
        max(0, min(1, value / maxValue))
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color(UIColor.systemGray5))
                    .frame(width: geometry.size.width, height: 10)
                    .cornerRadius(5)

                Rectangle()
                    .foregroundColor(color)
                    .frame(
                        width: CGFloat(self.progress) * geometry.size.width,
                        height: 10
                    )
                    .cornerRadius(5)
            }
        }.frame(height: 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            StatProgressBarView(value: 50, maxValue: 100, leadingText: "HP", progressBarColor: .orange)
            StatProgressBarView(value: 60, maxValue: 100, leadingText: "Attack", progressBarColor: .orange)
            StatProgressBarView(value: 10, maxValue: 100, leadingText: "Defense", progressBarColor: .orange)
        }
    }
}

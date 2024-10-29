//
//  JustifiedText.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 8/3/22.
//

import SwiftUI

struct JustifiedText: UIViewRepresentable {
    private let text: String
    private let font: UIFont

    init(_ text: String, font: UIFont = .systemFont(ofSize: 18)) {
        self.text = text
        self.font = font
    }

    func makeUIView(context: Context) -> UILabel {
        let textLabel = UILabel()
        textLabel.font = self.font
        textLabel.textAlignment = .justified
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.allowsDefaultTighteningForTruncation = true
        textLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        textLabel.clipsToBounds = true

        return textLabel
    }
    
    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.text = text
    }
}

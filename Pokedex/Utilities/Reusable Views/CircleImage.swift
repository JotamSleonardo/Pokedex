//
//  CircleImage.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 7/23/22.
//

import SwiftUI

struct CircleImage: View {
    public var image: Any
    public var imageSize: CGSize = CGSize(width: 250.0, height: 250.0)

    var body: some View {
        ZStack {
            if let imageURL = self.image as? URL {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
            } else if let image = self.image as? Image {
                image
                    .resizable()
                    .scaledToFit()
            } else {
                EmptyView()
            }
        }
        .frame(width: imageSize.width, height: imageSize.height)
        .background(Color.white)
        .clipShape(Circle())
        .overlay {
            Circle()
                .stroke(
                    Color.white,
                    lineWidth: 2
                )
        }
        .shadow(radius: 7.0)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(
            image: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")!
            ,
            imageSize: CGSize(width: 150.0, height: 150.0)
        )
    }
}

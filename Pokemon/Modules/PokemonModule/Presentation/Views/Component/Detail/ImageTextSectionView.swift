//
//  ImageTextSectionView.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 20/10/23.
//

import SwiftUI

struct ImageTextSectionView: View {
    @EnvironmentObject var pokemonDetailVM: PokemonDetailViewModel

    var body: some View {
        HStack{
            Image("pokemon")
                .resizable()
                .scaledToFit()
                .frame(height: 250)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                        .foregroundColor(.black)
                )
                .padding(.leading,1)
            Spacer(minLength: 10)
            Text(pokemonDetailVM.description)
                .font(.system(size: 18))
                .lineLimit(10)

        }
        .frame(height: 250)
    }
}

#Preview {
    ImageTextSectionView()
}

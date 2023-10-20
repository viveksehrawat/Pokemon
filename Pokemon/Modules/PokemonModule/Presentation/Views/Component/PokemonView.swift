//
//  PokemonView.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 20/10/23.
//

import SwiftUI

struct PokemonView: View {
    var pokemonId: Int
    var dismiss: () -> Void

    var body: some View {
        ScrollView{
            VStack{
                HeaderView(dismiss: {
                    dismiss()
                }, title: "Pokemon", number: "007")
                ImageTextSectionView()
                Spacer()
                HStack{
                    ItemView(title: "Height", subTitle: "5'7")
                    Spacer()
                    ItemView(title: "Weight", subTitle: "90.5 Kg")
                }
                Spacer()
                HStack{
                    ItemView(title: "Gender(s)", subTitle: "Male, Female")
                    Spacer()
                    ItemView(title: "Egg Groups", subTitle: "Monster, Dragon")
                }
                Spacer()
                HStack{
                    ItemView(title: "Ablities", subTitle: "Blaze, Solar-Power")
                    Spacer()
                    ItemView(title: "Types", subTitle: "Fire Flying")
                }
                Spacer()
                VStack{
                    Text("Weak Against")
                        .font(.system(size: 15))
                        .bold()
                    Text("Fight, Ground, Steel, Water, Grass")
                        .font(.system(size: 13))
                }
                StatsView()
            }
        }
        .padding(.horizontal, 30)
        .background(Color("backgroundColor"))

    }
}

#Preview {
    PokemonView(pokemonId: 1){
    }
}

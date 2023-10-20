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
    
    let types: [PokemonType] = [.electric, .ground, .fairy, .fire]
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                HeaderView(dismiss: {
                    dismiss()
                }, title: "Pokemon", number: "007")
                ImageTextSectionView()
                Spacer(minLength: 30)
                HStack{
                    ItemView(title: "Height", subTitle: "5'7")
                    Spacer()
                    ItemView(title: "Weight", subTitle: "90.5 Kg")
                    
                }
                Spacer(minLength: 30)
                HStack{
                    ItemView(title: "Gender(s)", subTitle: "Male, Female")
                    Spacer()
                    ItemView(title: "Egg Groups", subTitle: "Monster, Dragon")
                    
                }
                Spacer(minLength: 30)
                HStack{
                    ItemView(title: "Ablities", subTitle: "Blaze, Solar-Power")
                    Spacer()
                    ItemView(title: "Types", subTitle: "Fire Flying")
                    
                }
                Spacer(minLength: 30)
                
                VStack(alignment: .leading){
                    Text("Weak Against")
                        .font(.system(size: 18))
                        .bold()
                    Spacer(minLength: 30)
                    LazyHGrid(rows: [GridItem(.flexible())], spacing: 10) {
                        ForEach(types, id: \.self) { type in
                            PokemonTypes(type: type)
                        }
                    }
                }
                Spacer(minLength: 30)
                
                StatsView()
                Spacer(minLength: 30)
                GeometryReader { geometry in
                    HStack{
                        AppButton(title: "Previous") {
                            goToPrevious()
                        }
                        Spacer()
                        AppButton(title: "Next") {
                            goToNextPage()
                        }
                    }
                }
                Spacer(minLength: 30)
            }
        }
        .padding(.horizontal, 30)
        .background(Color("backgroundColor"))
        
    }
    
    func goToNextPage() {
        //        pageIndex += 1
    }
    
    func goToPrevious() {
        //        pageIndex -= 1
    }
}

#Preview {
    PokemonView(pokemonId: 1){
    }
}

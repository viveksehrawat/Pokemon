//
//  PokemonView.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 20/10/23.
//

import SwiftUI

struct PokemonView: View {
    
    @EnvironmentObject var vm: PokemonDetailViewModel
    
    var pokemonId: Int
    var dismiss: () -> Void
    //    var next: () -> Void
    //    var previous: () -> Void
    
    let types: [PokemonType] = [.electric, .ground, .fairy, .fire]
    
    var body: some View {
        AsyncContentView(source: vm) { detail in

        ScrollView {
            VStack(alignment: .leading, spacing: 30){
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

                HStack{
                    ItemView(title: "Gender(s)", subTitle: "Male, Female")
                    Spacer()
                    ItemView(title: "Egg Groups", subTitle: "Monster, Dragon")
                    
                }

                HStack{
                    ItemView(title: "Ablities", subTitle: "Blaze, Solar-Power")
                    Spacer()
                    QualityView(title: "Types", data: vm.typeNames)

                }

                QualityView(title: "Weak Against", data: vm.getAllWeaknesses())

                StatsView(statItems: vm.getStatItems())

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
        .scrollIndicators(.hidden)
        .padding(.horizontal, 30)
        .background(Color("backgroundColor"))
        .task {
            
        }
        
    }
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

//
//  PokemonView.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 20/10/23.
//

import SwiftUI

extension Color {
    static let labelGrayColor = Color(hex: "#2E3156")
}

extension Text {
    func setForegroundColor() -> Self {
        return self.foregroundColor(.labelGrayColor)
    }
}


struct PokemonView: View {
    
    @EnvironmentObject var vm: PokemonDetailViewModel
    
    var pokemonId: Int
    var dismiss: () -> Void
        
    var body: some View {
        
        AsyncContentView(source: vm) { detail in

        ScrollView {
            VStack(alignment: .leading, spacing: 30){
                HeaderView(dismiss: {
                    dismiss()
                }, title: detail.pokemonDetail?.name.uppercased() ?? "", number: String(format: "%03d", detail.pokemonDetail?.id ?? 0))
//                ImageTextSectionView()
                Spacer(minLength: 30)
//                HStack{
//                    ItemView(title: "Height", subTitle: vm.height)
//                    Spacer()
//                    ItemView(title: "Weight", subTitle: vm.weight)
//                }

//                HStack{
//                    ItemView(title: "Gender(s)", subTitle: vm.genders)
//                    Spacer()
//                    ItemView(title: "Egg Groups", subTitle: vm.eggGroups)
//                    
//                }

//                HStack{
//                    ItemView(title: "Ablities", subTitle:vm.abilities)
//                    Spacer()
//                    QualityView(title: "Types", data: vm.typeNames)
//
//                }

//                QualityView(title: "Weak Against", data: vm.getAllWeaknesses())
//
//                StatsView(statItems: vm.getStatItems())
//                EvolutionChainView()

                GeometryReader { geometry in
                    HStack{
                        if vm.currentPageIndex != 0 {
                           AppButton(title: "Previous") {
                               vm.goToPrevious()
                           }
                        }
                        
                        Spacer()
                        if vm.currentPageIndex != vm.pokemons.endIndex - 1 {
                            AppButton(title: "Next") {
                                vm.goToNextPage()
                            }
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
}

#Preview {
    PokemonView(pokemonId: 1){
    }
}

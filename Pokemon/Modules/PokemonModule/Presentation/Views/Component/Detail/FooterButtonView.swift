//
//  FooterButtonView.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 24/10/23.
//

import SwiftUI

struct FooterButtonView: View {
    @EnvironmentObject var vm: PokemonDetailViewModel

    var body: some View {
        GeometryReader { geometry in
            HStack{
                if vm.currentPageIndex != 0 {
                    AppButton(title: vm.pokemons[vm.currentPageIndex - 1].name.capitalized, isNextButton: false) {
                       vm.goToPrevious()
                   }
                }
                
                Spacer()
                if vm.currentPageIndex != vm.pokemons.endIndex - 1 {
                    AppButton(title: vm.pokemons[vm.currentPageIndex + 1].name.capitalized, isNextButton: true) {
                        vm.goToNextPage()
                    }
                }
            }
        }
    }
}

#Preview {
    FooterButtonView()
}

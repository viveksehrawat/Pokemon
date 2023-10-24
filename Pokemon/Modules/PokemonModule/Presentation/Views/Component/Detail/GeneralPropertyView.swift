//
//  GeneralPropertyView.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 24/10/23.
//

import SwiftUI

struct GeneralPropertyView: View {
    
    @EnvironmentObject var vm: PokemonDetailViewModel
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 40) {
                VStack(alignment: .leading, spacing: 30) {
                    ItemView(title: "Height", subTitle: vm.pageData.height)
                    ItemView(title: "Gender", subTitle: vm.pageData.genders)
                    ItemView(title: "Abilities", subTitle: vm.pageData.abilities)
                }
                
                VStack(alignment: .leading, spacing: 30) {
                    ItemView(title: "Weight", subTitle: vm.pageData.weight)
                    ItemView(title: "EggGroups", subTitle: vm.pageData.eggGroups)
                    QualityView(title: "Types", data: vm.pageData.typeNames)
                }
            }
            Spacer(minLength: 30)
            QualityView(title: "Weak Against", data: vm.pageData.getAllWeaknesses())
        }
    }
}

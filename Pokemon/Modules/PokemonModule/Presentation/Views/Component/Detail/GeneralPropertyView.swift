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
                    ItemView(title: "Height", subTitle: vm.height)
                    ItemView(title: "Gender", subTitle: vm.genders)
                    ItemView(title: "Abilities", subTitle: vm.abilities)

                }

                VStack(alignment: .leading, spacing: 30) {
                    ItemView(title: "Weight", subTitle: vm.weight)

                    ItemView(title: "EggGroups", subTitle: vm.eggGroups)

                    QualityView(title: "Types", data: vm.typeNames)
//                    Text("Types")
//                        .font(.system(size: 18))
//                        .setForegroundColor()
//                        .bold()
//                    QualityView(title: "Weak Against", data: vm.getAllWeaknesses())

                }
            }
//            PokemonTypeView()
        }
    }
}

//
//  EvolutionChainView.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 21/10/23.
//

import SwiftUI
import Kingfisher

struct EvolutionChainDetail: Hashable, Identifiable {
    var id: Int
    var imageUrl: String
    var colors: [Color]

}

struct EvolutionChainView: View {
    
    var evolutionChainDetails: [EvolutionChainDetail]
    
//    private var gradientColors: [Color] {
//        let types = pokemon.types
//        let name = types.map {$0.color}
//        return name
//    }

    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Evolution Chain")
                .font(.system(size: 20))
                .setForegroundColor()
            
            HStack {
                ForEach(evolutionChainDetails, id: \.self) { detail in
                    ZStack {
                        KFImage(URL(string: detail.imageUrl))
                            .resizable()
                            .scaledToFit().padding(.all, 10)
                    }
                    .frame(width: 84, height: 117)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                            .foregroundColor(.black)
                    )
                    .addGradient(colors: detail.colors)
                    .cornerRadius(12)
                    if evolutionChainDetails.count > 1 && detail.id != evolutionChainDetails.last?.id {
                        Image(systemName: "arrow.right")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}
//#Preview {
//    EvolutionChainView()
//}

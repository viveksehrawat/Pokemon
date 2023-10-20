//
//  PokemonDetailView.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 19/10/23.
//

import SwiftUI

struct PokemonDetailView: View {
    var selectedIndex: Int
    @Environment(\.dismiss) var dismiss

    @State private var pageIndex = 0
    private let pages: [Int] = [0,1,2,3,4,5,6]
    
    var body: some View {
        TabView(selection: $pageIndex) {
            ForEach(pages, id: \.self) { page in
                VStack {
                    

                    PokemonView(pokemonId: page){
                        dismiss()
                    }
                    HStack{
                        Button("Previous", action: goToPrevious)
                                .buttonStyle(.bordered)
                        Button("Next", action: goToNextPage)
                                .buttonStyle(.bordered)
                    }
                }.tag(page)
            }
        }
        .background(Color("backgroundColor"))
        .animation(.easeInOut, value: pageIndex)
        .tabViewStyle(.page(indexDisplayMode: .never))
        
    }
    
    func goToNextPage() {
        pageIndex += 1
    }
    
    func goToPrevious() {
        pageIndex -= 1
    }
}

#Preview {
    PokemonDetailView(selectedIndex: 0)
}

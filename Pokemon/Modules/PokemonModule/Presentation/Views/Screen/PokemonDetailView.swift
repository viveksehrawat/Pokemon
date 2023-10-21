//
//  PokemonDetailView.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 19/10/23.
//

import SwiftUI

struct PokemonDetailView: View {
    
    @ObservedObject private(set) var viewModel: PokemonDetailViewModel
    @Environment(\.dismiss) var dismiss

    private let pages: [Int] = [0,1,2,3,4,5,6]
    
    var body: some View {
        TabView(selection: $viewModel.currentIndex) {
            ForEach(pages, id: \.self) { page in
                PokemonView(pokemonId: page){
                    dismiss()
                }
                .tag(page)
                .gesture(DragGesture())
            }
            .environmentObject(viewModel)
        }
        .background(Color("backgroundColor"))
        .animation(.easeInOut, value: viewModel.currentIndex)
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

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
    
    var body: some View {
            TabView(selection: $viewModel.currentPageIndex) {
                ForEach(viewModel.pages, id: \.self) { page in
                        PokemonView(pokemonId: page){
                            dismiss()
                        }
                        .tag(page)
                        .gesture(DragGesture())
                    }
                }
                .environmentObject(viewModel)
            .background(Color("backgroundColor"))
            .animation(.easeInOut, value: viewModel.currentPageIndex)
            .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

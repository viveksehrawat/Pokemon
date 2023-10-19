//
//  PokemonSearchView.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 19/10/23.
//

import SwiftUI

struct PokemonSearchView: View {
    @State private var searchableText : String = ""
    var body: some View {
        HStack{
            HStack{
                TextField("Name or Number", text: $searchableText)
                    .font(.system(size: 20))
                    .padding()
                    .cornerRadius(8)
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.gray)
                    .padding()
            }
            .background(Color("textFieldColor"))
            
            Spacer(minLength: 20)
            Button{
                
            }label: {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 60, height: 60)
                    .foregroundColor(Color("filterBackgroundColor"))
                    .overlay(
                        Image(systemName: "slider.horizontal.3")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    )
            }
        }
        .background(Color("backgroundColor"))
    }
}

#Preview {
    PokemonSearchView()
}

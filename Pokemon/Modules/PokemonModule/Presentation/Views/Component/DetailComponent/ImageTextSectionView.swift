//
//  ImageTextSectionView.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 20/10/23.
//

import SwiftUI

struct ImageTextSectionView: View {
    
    var body: some View {
        HStack{
            Image("pokemon")
                .resizable()
                .scaledToFit()
                .frame(height: 250)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                        .foregroundColor(.black)
                )
            Spacer(minLength: 10)
            Text("This is Pokemon Spits fire that is hot enough to melt Known to cause forest fires unintenionally. When expeliing a blast of super...")
                .font(.system(size: 24))
        }
    }
}

#Preview {
    ImageTextSectionView()
}

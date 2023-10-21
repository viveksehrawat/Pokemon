//
//  StatsView.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 20/10/23.
//

import SwiftUI

struct Stat: Identifiable {
    var id = UUID()
    let name: String
    let percent: Int
}

struct StatsView: View {
    
    @State var stats = [
           Stat(name: "Sp Defence", percent: 74),
           Stat(name: "Defence", percent: 56),
           Stat(name: "Attack", percent: 48),
           Stat(name: "HP", percent: 90),
           Stat(name: "Speed", percent: 87),
       ]
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Stats")
                .font(.system(size: 25))
                .bold()
                .padding(.vertical, 10)
            LazyVGrid(columns: [GridItem()], alignment: .center) {
                ForEach(stats){ stat in
                    HStack(alignment: .center){
                        Text(stat.name)
                            .font(.system(size: 15))
                            .padding(.trailing, 20)
                            .frame(width: 100, alignment: .trailing)
                        BarView(percentage: stat.percent)
                    }
                }
            }
        }
        .padding()
        .background(Color("statsBackgroundColor"))
    }
}

#Preview {
    StatsView()
}

struct BarView: View {
    let percentage: Int
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: 10)
                    .foregroundColor(Color.gray)
                
                Rectangle()
                    .frame(width: CGFloat(percentage) * geometry.size.width / 100, height: 10)
                    .foregroundColor(Color("filterBackgroundColor"))
            }
        }
    }
}

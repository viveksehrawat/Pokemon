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
           Stat(name: "First", percent: 24),
           Stat(name: "2", percent: 74),
           Stat(name: "3", percent: 56),
           Stat(name: "4", percent: 48),
           Stat(name: "5", percent: 90),
           Stat(name: "6", percent: 87),
       ]
    
    var body: some View {
        List(stats) { stat in
            HStack{
                Text(stat.name)
                    .padding(.trailing, 10)
                    .frame(width: 100, alignment: .trailing)
                
                BarView(percentage: stat.percent)
            }
        }
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
                    .foregroundColor(Color.green)
            }
        }
    }
}

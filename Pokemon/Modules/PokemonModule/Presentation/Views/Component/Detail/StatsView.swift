//
//  StatsView.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 20/10/23.
//

import SwiftUI

class StatItem: Hashable, Identifiable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: StatItem, rhs: StatItem) -> Bool {
        lhs.title == rhs.title
    }

    public var id: ObjectIdentifier {
        ObjectIdentifier(self)
    }

    init(title: String, progress: Float) {
        self.title = title
        self.progress = progress
    }

    var title: String
    let progress: Float
}

struct StatsView: View {

    let statItems: [StatItem]

    var body: some View {
        VStack(alignment: .leading){
            Text("Stats")
                .font(.system(size: 20))
                .setForegroundColor()
                .bold()
                .padding(.vertical, 5)
            LazyVGrid(columns: [GridItem()], alignment: .center, spacing: 20) {
                ForEach(statItems, id: \.self) { statItem in
                    HStack(alignment: .center){
                        Text(statItem.title.capitalized)
                            .font(.system(size: 12))
                            .setForegroundColor()
                            .padding(.trailing, 20)
                            .frame(width: 120, alignment: .leading)
                        BarView(percentage: statItem.progress)
                    }
                }
            }
        }
        .padding()
        .background(Color("statsBackgroundColor"))
    }
}

//#Preview {
//    StatsView()
//}

struct BarView: View {
    let percentage: Float
    
    var body: some View {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: geometry.size.width, height: 12)
                        .foregroundColor(Color.gray)

                    Rectangle()
                        .frame(width: CGFloat(percentage) * geometry.size.width / 100, height: 12)
                        .foregroundColor(Color("filterBackgroundColor"))

                    Text(String(format: "%.1f%%", percentage))
                        .font(.system(size: 10))
                        .foregroundColor(.white)
                        .padding(.leading, 5)
                }
            }
        }
    }
    



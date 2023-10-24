//
//  Colors.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 20/10/23.
//

import SwiftUI


extension PokemonType {
    var color: Color {
    
        switch self {
        case .normal:
            return  Color(hex: "#DDCBD0")
        case .fighting:
            return  Color(hex: "#FCC1B0")
        case .flying:
            return  Color(hex: "#B2D2E8")
        case .poison:
            return  Color(hex: "#CFB7ED")
        case .ground:
            return Color(hex: "#F4D1A6")
        case .rock:
            return Color(hex: "#C5AEA8")
        case .bug:
            return Color(hex: "#C1E0C8")
        case .ghost:
            return Color(hex: "#D7C2D7")
        case .steel:
            return Color(hex: "#C2D4CE")
        case .fire:
            return Color(hex: "#EDC2C4")
        case .water:
            return Color(hex: "#CBD5ED")
        case .grass:
            return Color(hex: "#C0D4C8")
        case .electric:
            return Color(hex: "#E2E2A0")
        case .psychic:
            return Color(hex: "#DDC0CF")
        case .ice:
            return Color(hex: "#C7D7DF")
        case .dragon:
            return Color(hex: "#CADCDF")
        case .dark:
            return Color(hex: "#C6C5E3")
        case .fairy:
            return Color(hex: "#E4C0CF")
        case .unknown:
            return Color(hex: "#CODFDD")
        case .shadow:
            return Color(hex: "#CACACA")
//        default: return  Color(hex: "")

        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

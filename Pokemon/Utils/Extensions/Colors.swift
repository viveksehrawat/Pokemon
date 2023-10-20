//
//  Colors.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 20/10/23.
//

import SwiftUI



extension Color {
    
    static func pokemon(type: PokemonType) -> Color {
        switch type {
            case .fire: return Color(hex: "EDC2C4")
            case .poison: return Color(hex: "CFB7ED")
            case .water: return Color(hex: "CBD5ED")
            case .electric: return Color(hex: "E2E2A0")
            case .psychic: return Color(hex: "DDC0CF")
            case .normal: return Color(hex: "DDCBD0")
            case .ground: return Color(hex: "F4D1A6")
            case .flying: return Color(hex: "B2D2E8")
            case .fairy: return Color(hex: "E4C0CF")
            default: return  Color(hex: "")
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

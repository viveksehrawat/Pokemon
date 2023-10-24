//
//  GradientExtension.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 24/10/23.
//

import Foundation
import SwiftUI

extension View {

    func addGradient(colors: [Color]) -> some View {
        let gradient = LinearGradient(gradient: Gradient(colors: colors), startPoint: .top, endPoint: .bottom)
        return self.background(gradient)
    }

    func removeGradient() -> some View {
        return self
    }
}

extension Color {
    static let labelGrayColor = Color(hex: "#2E3156")
}

extension Text {
    func setForegroundColor() -> Self {
        return self.foregroundColor(.labelGrayColor)
    }
}

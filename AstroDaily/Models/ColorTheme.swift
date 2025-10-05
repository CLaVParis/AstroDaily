//
//  ColorTheme.swift
//  AstroDaily
//
//  Created by Hu AN on 01/10/2025.
//

import SwiftUI

// MARK: - Color Theme
struct ColorTheme {
    static let primary = Color.accentColor
    static let secondary = Color.secondary
    
    static let background = Color(UIColor.systemBackground)
    static let secondaryBackground = Color(UIColor.secondarySystemBackground)
    static let tertiaryBackground = Color(UIColor.tertiarySystemBackground)
    
    static let primaryText = Color(UIColor.label)
    static let secondaryText = Color(UIColor.secondaryLabel)
    static let tertiaryText = Color(UIColor.tertiaryLabel)
    
    static let success = Color.green
    static let warning = Color.orange
    static let error = Color.red
    static let info = Color.blue
    
    static let buttonBackground = Color.accentColor
    static let buttonText = Color.white
    
    static let videoBackground = Color.black
    static let videoOverlay = Color.black.opacity(0.3)
    
    static let infoBannerBackground = Color.blue.opacity(0.1)
    static let infoBannerBorder = Color.blue.opacity(0.3)
    static let warningBannerBackground = Color.orange.opacity(0.1)
    static let warningBannerBorder = Color.orange.opacity(0.3)
}

// MARK: - Dynamic Colors Extension
extension Color {
    static let astroPrimary = Color("AstroPrimary")
    static let astroSecondary = Color("AstroSecondary")
    static let astroBackground = Color("AstroBackground")
    static let astroCardBackground = Color("AstroCardBackground")
}

// MARK: - Dark Mode Support
extension View {
    
    func astroDarkModeSupport() -> some View {
        self
            .preferredColorScheme(nil)
            .background(ColorTheme.background)
    }
    
}

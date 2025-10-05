//
//  APODHistoryView.swift
//  AstroDaily
//
//  Created by Hu AN on 01/10/2025.
//

import SwiftUI

// MARK: - APOD History View
struct APODHistoryView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: UIConstants.spacing) {
                Image(systemName: "calendar.badge.clock")
                    .font(.system(size: UIConstants.largeFontSize))
                    .foregroundColor(ColorTheme.primary)
                
                Text("APOD History")
                    .font(FontTheme.style(for: .sectionTitle))
                    .foregroundColor(ColorTheme.primaryText)
                
                Text("Browse past Astronomy Pictures of the Day")
                    .font(FontTheme.style(for: .bodyText))
                    .foregroundColor(ColorTheme.secondaryText)
                    .multilineTextAlignment(.center)
                
                Text("This feature will be implemented in future updates")
                    .font(FontTheme.style(for: .caption))
                    .foregroundColor(ColorTheme.tertiaryText)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ColorTheme.background)
            .navigationTitle("History")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .astroDarkModeSupport()
        .standardFontSize()
    }
}

#Preview {
    APODHistoryView()
}

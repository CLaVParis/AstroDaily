//
//  FallbackDateBanner.swift
//  AstroDaily
//
//  Created by Hu AN on 01/10/2025.
//

import SwiftUI

// MARK: - Fallback Date Banner
struct FallbackDateBanner: View {
    let requestedDate: Date
    let actualDate: Date
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "info.circle.fill")
                .foregroundColor(ColorTheme.warning)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Showing Fallback Date Content")
                    .font(FontTheme.style(for: .caption))
                    .fontWeight(.semibold)
                    .foregroundColor(ColorTheme.warning)
                
                Text("Requested date \(DateFormatter.displayDateFormatter.string(from: requestedDate)) has no content, showing APOD from \(DateFormatter.displayDateFormatter.string(from: actualDate))")
                    .font(FontTheme.caption2)
                    .foregroundColor(ColorTheme.secondaryText)
            }
            
            Spacer()
        }
        .padding(.horizontal, UIConstants.smallSpacing)
        .padding(.vertical, 8)
        .background(ColorTheme.warningBannerBackground)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(ColorTheme.warningBannerBorder, lineWidth: 1)
        )
    }
}

#Preview {
    FallbackDateBanner(
        requestedDate: Date(),
        actualDate: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
    )
    .padding()
}

//
//  CacheBanner.swift
//  AstroDaily
//
//  Created by Hu AN on 01/10/2025.
//

import SwiftUI

// MARK: - Cache Banner
struct CacheBanner: View {
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "externaldrive.fill")
                .foregroundColor(ColorTheme.info)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Offline Content")
                    .font(FontTheme.style(for: .caption))
                    .fontWeight(.semibold)
                    .foregroundColor(ColorTheme.info)
                
                Text("Network unavailable, showing cached APOD content")
                    .font(FontTheme.caption2)
                    .foregroundColor(ColorTheme.secondaryText)
            }
            
            Spacer()
        }
        .padding(.horizontal, UIConstants.smallSpacing)
        .padding(.vertical, 8)
        .background(ColorTheme.infoBannerBackground)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(ColorTheme.infoBannerBorder, lineWidth: 1)
        )
    }
}

#Preview {
    CacheBanner()
        .padding()
}

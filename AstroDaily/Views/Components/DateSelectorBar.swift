//
//  DateSelectorBar.swift
//  AstroDaily
//
//  Created by Hu AN on 01/10/2025.
//

import SwiftUI

// MARK: - Date Selector Bar
struct DateSelectorBar: View {
    let currentDate: Date
    let onDatePickerTapped: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Currently Viewing Date")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text(DateFormatter.displayDateFormatter.string(from: currentDate))
                    .font(.headline)
                    .fontWeight(.semibold)
            }
            
            Spacer()
            
            Button(action: {
                onDatePickerTapped()
            }) {
                HStack(spacing: UIConstants.smallSpacing / 2) {
                    Image(systemName: "calendar")
                    Text("Select Date")
                        .font(FontTheme.style(for: .callout))
                }
                .padding(.horizontal, UIConstants.horizontalPadding)
                .padding(.vertical, 8)
                .background(ColorTheme.infoBannerBackground)
                .foregroundColor(ColorTheme.info)
                .cornerRadius(UIConstants.largeCornerRadius)
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Select APOD date")
            .accessibilityHint("Tap to select the astronomy picture date to view")
        }
        .padding(.horizontal, UIConstants.horizontalPadding)
        .padding(.vertical, UIConstants.smallSpacing)
        .background(ColorTheme.secondaryBackground)
        .cornerRadius(UIConstants.cornerRadius)
    }
}

#Preview {
    DateSelectorBar(currentDate: Date(), onDatePickerTapped: {})
        .padding()
}

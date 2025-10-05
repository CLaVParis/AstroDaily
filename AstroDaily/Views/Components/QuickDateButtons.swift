//
//  QuickDateButtons.swift
//  AstroDaily
//
//  Created by Hu AN on 01/10/2025.
//

import SwiftUI

// MARK: - Quick Date Buttons
struct QuickDateButtons: View {
    @Binding var selectedDate: Date
    let onDateSelected: (Date) -> Void
    
    private let quickDates: [(String, Int)] = [
        ("Yesterday", QuickDateConstants.yesterday),
        ("3 Days Ago", QuickDateConstants.threeDaysAgo),
        ("1 Week Ago", QuickDateConstants.oneWeekAgo),
        ("1 Month Ago", QuickDateConstants.oneMonthAgo)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: UIConstants.smallSpacing) {
            Text("Quick Selection")
                .font(FontTheme.style(for: .cardTitle))
                .foregroundColor(ColorTheme.primaryText)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: UIConstants.smallSpacing) {
                ForEach(quickDates, id: \.0) { dateInfo in
                    QuickDateButton(
                        title: dateInfo.0,
                        daysOffset: dateInfo.1,
                        selectedDate: $selectedDate,
                        onDateSelected: onDateSelected
                    )
                }
            }
        }
        .padding()
        .background(ColorTheme.secondaryBackground)
        .cornerRadius(UIConstants.cornerRadius)
    }
}

// MARK: - Quick Date Button
struct QuickDateButton: View {
    let title: String
    let daysOffset: Int
    @Binding var selectedDate: Date
    let onDateSelected: (Date) -> Void
    
    private var targetDate: Date {
        Calendar.current.date(byAdding: .day, value: daysOffset, to: Date()) ?? Date()
    }
    
    private var isSelected: Bool {
        Calendar.current.isDate(selectedDate, inSameDayAs: targetDate)
    }
    
    var body: some View {
        Button(action: {
            selectedDate = targetDate
            onDateSelected(targetDate)
        }) {
            VStack(spacing: 4) {
                Text(title)
                    .font(FontTheme.style(for: .caption))
                    .fontWeight(.medium)
                
                Text(DateFormatter.displayDateFormatter.string(from: targetDate))
                    .font(FontTheme.caption2)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, UIConstants.smallSpacing)
            .background(isSelected ? ColorTheme.primary.opacity(0.2) : ColorTheme.tertiaryBackground)
            .foregroundColor(isSelected ? ColorTheme.primary : ColorTheme.primaryText)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isSelected ? ColorTheme.primary : Color.clear, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    QuickDateButtons(selectedDate: .constant(Date()), onDateSelected: { _ in })
        .padding()
}

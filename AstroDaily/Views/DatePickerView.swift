//
//  DatePickerView.swift
//  AstroDaily
//
//  Created by Hu AN on 01/10/2025.
//

import SwiftUI

// MARK: - Date Picker View
struct DatePickerView: View {
    @Binding var selectedDate: Date
    @Binding var isPresented: Bool
    let onDateSelected: (Date) -> Void
    
    @State private var tempDate: Date
    
    // APOD start date (June 16, 1995)
    private let apodStartDate: Date = {
        guard let startDate = Calendar.current.date(from: DateComponents(year: APODDateConstants.startYear, month: APODDateConstants.startMonth, day: APODDateConstants.startDay)) else {
            logError("Failed to create APOD start date, using fallback")
            return Calendar.current.date(from: DateComponents(year: APODDateConstants.fallbackYear, month: APODDateConstants.fallbackMonth, day: APODDateConstants.fallbackDay)) ?? Date()
        }
        return startDate
    }()
    
    init(selectedDate: Binding<Date>, isPresented: Binding<Bool>, onDateSelected: @escaping (Date) -> Void) {
        self._selectedDate = selectedDate
        self._isPresented = isPresented
        self.onDateSelected = onDateSelected
        self._tempDate = State(initialValue: selectedDate.wrappedValue)
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: UIConstants.spacing) {
                        VStack(spacing: 8) {
                            Image(systemName: "calendar.circle.fill")
                                .font(.system(size: geometry.size.width > UIConstants.tabletBreakpoint ? UIConstants.tabletFontSize : UIConstants.phoneFontSize))
                                .foregroundColor(.blue)
                            
                            Text("Select APOD Date")
                                .font(geometry.size.width > UIConstants.tabletBreakpoint ? FontTheme.style(for: .pageTitle) : FontTheme.style(for: .sectionTitle))
                            
                            Text("Browse NASA astronomy pictures from any day in history")
                                .font(FontTheme.style(for: .bodyText))
                                .foregroundColor(ColorTheme.secondaryText)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, geometry.size.width > UIConstants.tabletBreakpoint ? UIConstants.tabletPadding : UIConstants.phonePadding)
                        }
                        .padding(.top)
                        
                        DatePicker(
                            "Select Date",
                            selection: $tempDate,
                            in: apodStartDate...Date(),
                            displayedComponents: .date
                        )
                        .datePickerStyle(.graphical)
                        .padding(.horizontal, geometry.size.width > UIConstants.tabletBreakpoint ? UIConstants.tabletPadding : UIConstants.phonePadding)
                        .scaleEffect(geometry.size.width > UIConstants.tabletBreakpoint ? UIConstants.tabletScale : UIConstants.phoneScale)
                        
                        Spacer(minLength: UIConstants.minSpacerLength)
                        HStack(spacing: 16) {
                            Button("Cancel") {
                                isPresented = false
                            }
                            .buttonStyle(.bordered)
                            .frame(maxWidth: .infinity)
                            
                            Button("Load APOD") {
                                selectedDate = tempDate
                                onDateSelected(tempDate)
                                isPresented = false
                            }
                            .buttonStyle(.borderedProminent)
                            .frame(maxWidth: .infinity)
                        }
                        .padding(.horizontal, geometry.size.width > UIConstants.tabletBreakpoint ? UIConstants.tabletPadding : UIConstants.phonePadding)
                        .padding(.bottom, geometry.size.width > UIConstants.tabletBreakpoint ? UIConstants.tabletPadding : UIConstants.phonePadding)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: geometry.size.height)
                }
            }
            .navigationTitle("Date Selection")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        selectedDate = tempDate
                        onDateSelected(tempDate)
                        isPresented = false
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .astroDarkModeSupport()
        .standardFontSize()
    }
}


#Preview {
    @Previewable @State var selectedDate = Date()
    @Previewable @State var isPresented = true
    
    return DatePickerView(
        selectedDate: $selectedDate,
        isPresented: $isPresented,
        onDateSelected: { _ in }
    )
}

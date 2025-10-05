//
//  APODContentView.swift
//  AstroDaily
//
//  Created by Hu AN on 01/10/2025.
//

import SwiftUI

// MARK: - APOD Content View
struct APODContentView: View {
    @StateObject private var viewModel = APODViewModel()
    @State private var showingDatePicker = false
    @State private var selectedDate = Date()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: UIConstants.spacing) {
                    DateSelectorBar(
                        currentDate: viewModel.currentRequestedDate,
                        showingDatePicker: $showingDatePicker
                    )
                    
                    // Handle different view states
                    switch viewModel.state {
                    case .loading:
                        LoadingView()
                    case .loaded(let apod, let isFallbackDate, let isFromCache):
                        VStack(spacing: UIConstants.smallSpacing) {
                            // Show banner if we're displaying a fallback date
                            if isFallbackDate {
                                FallbackDateBanner(
                                    requestedDate: viewModel.currentRequestedDate,
                                    actualDate: apod.date
                                )
                            }
                            
                            // Show banner if data is from cache
                            if isFromCache {
                                CacheBanner()
                            }
                            
                            APODDetailView(apod: apod)
                        }
                    case .error(let error):
                        ErrorView(error: error) {
                            viewModel.refresh()
                        }
                    case .empty:
                        EmptyStateView {
                            viewModel.loadTodaysAPOD()
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("APOD")
            .navigationBarTitleDisplayMode(.large)
            .refreshable {
                viewModel.refresh()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .astroDarkModeSupport()
        .standardFontSize()
        .sheet(isPresented: $showingDatePicker) {
            DatePickerView(
                selectedDate: $selectedDate,
                isPresented: $showingDatePicker,
                onDateSelected: { date in
                    viewModel.loadCustomDateAPOD(for: date)
                }
            )
        }
        .onAppear {
            if case .empty = viewModel.state {
                viewModel.loadTodaysAPOD()
            }
        }
    }
}

#Preview {
    APODContentView()
}

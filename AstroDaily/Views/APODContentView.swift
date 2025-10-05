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
    @Environment(\.coordinator) private var coordinator
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: UIConstants.spacing) {
                    DateSelectorBar(
                        currentDate: viewModel.currentRequestedDate,
                        onDatePickerTapped: {
                            coordinator.showDatePicker(
                                selectedDate: viewModel.currentRequestedDate,
                                onDateSelected: { date in
                                    viewModel.loadCustomDateAPOD(for: date)
                                }
                            )
                        }
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

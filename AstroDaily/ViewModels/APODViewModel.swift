//
//  APODViewModel.swift
//  AstroDaily
//
//  Created by Hu AN on 01/10/2025.
//

import Foundation
import SwiftUI

// MARK: - APOD View State
enum APODViewState {
    case loading
    case loaded(APOD, isFallbackDate: Bool = false, isFromCache: Bool = false)
    case error(Error)
    case empty
}

// MARK: - APOD View Model
class APODViewModel: ObservableObject {
    @Published var state: APODViewState = .empty
    @Published var isLoading: Bool = false
    @Published var currentRequestedDate: Date = Date()
    
    @Injected(APODServiceProtocol.self) private var apodService: APODServiceProtocol
    
    init() {
    }
    
    func loadTodaysAPOD() {
        currentRequestedDate = Date()
        Task {
            await fetchTodaysAPOD()
        }
    }
    
    func loadCustomDateAPOD(for date: Date) {
        currentRequestedDate = date
        Task {
            await fetchAPOD(for: date)
        }
    }
    
    func refresh() {
        Task {
            await fetchAPOD(for: currentRequestedDate)
        }
    }
    
    private func fetchTodaysAPOD() async {
        await MainActor.run {
            isLoading = true
            state = .loading
        }
        
        do {
            let result = try await apodService.fetchTodaysAPOD()
            await MainActor.run {
                state = .loaded(result.apod, isFallbackDate: result.isFallbackDate, isFromCache: result.isFromCache)
                isLoading = false
            }
        } catch {
            await MainActor.run {
                state = .error(error)
                isLoading = false
            }
        }
    }
    
    private func fetchAPOD(for date: Date) async {
        await MainActor.run {
            isLoading = true
            state = .loading
        }
        
        do {
            let result = try await apodService.fetchAPOD(for: date)
            await MainActor.run {
                state = .loaded(result.apod, isFallbackDate: result.isFallbackDate, isFromCache: result.isFromCache)
                isLoading = false
            }
        } catch {
            await MainActor.run {
                state = .error(error)
                isLoading = false
            }
        }
    }
    
}


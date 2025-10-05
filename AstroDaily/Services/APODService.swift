//
//  APODService.swift
//  AstroDaily
//
//  Created by Hu AN on 01/10/2025.
//

import Foundation

// MARK: - APOD Service Implementation
class APODService: APODServiceProtocol {
    @Injected(NetworkServiceProtocol.self) private var networkService: NetworkServiceProtocol
    @Injected(CacheServiceProtocol.self) private var cacheService: CacheServiceProtocol
    private let maxRetryDays: Int = 30
    
    init() {
    }
    
    func fetchTodaysAPOD() async throws -> APODResult {
        let today = Date()
        return try await fetchAPODWithFallback(for: today)
    }
    
    func fetchAPOD(for date: Date) async throws -> APODResult {
        return try await fetchAPODWithFallback(for: date)
    }
    
    private func fetchAPODWithFallback(for date: Date) async throws -> APODResult {
        var currentDate = date
        var lastError: Error?
        
        // If requested date has no content, try up to 30 days back
        for _ in 0..<maxRetryDays {
            do {
                let apod = try await fetchAPODForSpecificDate(currentDate)
                
                try await cacheService.cacheAPOD(apod)
                
                let isFallback = !Calendar.current.isDate(apod.date, inSameDayAs: date)
                return APODResult(apod: apod, isFromCache: false, isFallbackDate: isFallback)
            } catch {
                lastError = error
                
                // If it's a no-content error, try the previous day
                if case NetworkError.serverError(let statusCode) = error {
                    // Check for no-content status codes
                    if HTTPStatusCodes.noContentStatusCodes.contains(statusCode) {
                        currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate) ?? currentDate
                        continue
                    }
                }
                
                // For other errors, try to use cached data
                if let cachedAPOD = await cacheService.getCachedAPOD() {
                    logInfo("Network error occurred, loading cached APOD: \(cachedAPOD.title)")
                    let isFallback = !Calendar.current.isDate(cachedAPOD.date, inSameDayAs: date)
                    return APODResult(apod: cachedAPOD, isFromCache: true, isFallbackDate: isFallback)
                }
                
                throw error
            }
        }
        
        // If all retries failed, return cached data if available
        if let cachedAPOD = await cacheService.getCachedAPOD() {
            logInfo("Network failed, loading cached APOD: \(cachedAPOD.title)")
            let isFallback = !Calendar.current.isDate(cachedAPOD.date, inSameDayAs: date)
            return APODResult(apod: cachedAPOD, isFromCache: true, isFallbackDate: isFallback)
        }
        throw lastError ?? NetworkError.noContentForDate(date)
    }
    
    private func fetchAPODForSpecificDate(_ date: Date) async throws -> APOD {
        try validateDate(date)
        
        let dateString = DateFormatter.apodDateFormatter.string(from: date)
        let url = "\(APIConfiguration.apodURL)?date=\(dateString)"
        
        let response: APODResponse = try await networkService.request(
            url: url,
            responseType: APODResponse.self
        )
        
        return try APOD(from: response)
    }
    
    private func validateDate(_ date: Date) throws {
        // APOD started on June 16, 1995
        guard let apodStartDate = Calendar.current.date(from: DateComponents(year: APODDateConstants.startYear, month: APODDateConstants.startMonth, day: APODDateConstants.startDay)) else {
            throw NetworkError.invalidDate(date)
        }
        
        if date < apodStartDate {
            throw NetworkError.dateOutOfRange(date)
        }
        
        // Can't request future dates
        let today = Date()
        if date > today {
            throw NetworkError.invalidDate(date)
        }
    }
}

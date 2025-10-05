//
//  NetworkModels.swift
//  AstroDaily
//
//  Created by Hu AN on 01/10/2025.
//

import Foundation

// MARK: - Network Error Types
enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError(Error)
    case serverError(Int)
    case networkError(Error)
    case noContentForDate(Date)
    case invalidDate(Date)
    case dateOutOfRange(Date)
    case imageTooLarge
    case invalidImageData
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .decodingError(let error):
            return "Data parsing error: \(error.localizedDescription)"
        case .serverError(let code):
            return "Server error, code: \(code)"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .noContentForDate(let date):
            return "Date \(DateFormatter.displayDateFormatter.string(from: date)) has no available content"
        case .invalidDate(let date):
            return "Invalid date: \(DateFormatter.displayDateFormatter.string(from: date))"
        case .dateOutOfRange(let date):
            return "Date out of range: \(DateFormatter.displayDateFormatter.string(from: date)). APOD starts from June 16, 1995"
        case .imageTooLarge:
            return "Image file is too large (maximum 50MB)"
        case .invalidImageData:
            return "Invalid image data format"
        }
    }
}

// MARK: - API Configuration
struct APIConfiguration {
    static let baseURL = "http://127.0.0.1:8000"
    static let timeoutInterval: TimeInterval = NetworkConstants.timeoutInterval
    
    static var apodURL: String {
        return "\(baseURL)/v1/apod"
    }
}

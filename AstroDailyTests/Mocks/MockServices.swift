//
//  MockServices.swift
//  AstroDailyTests
//
//  Created by Hu AN on 01/10/2025.
//

import Foundation
import UIKit
@testable import AstroDaily

class MockNetworkService: NetworkServiceProtocol {
    var shouldSucceed: Bool = true
    var mockData: Data?
    var mockError: Error?
    var requestCount: Int = 0

    func request<T: Codable>(url: String, responseType: T.Type) async throws -> T {
        requestCount += 1
        if shouldSucceed {
            guard let data = mockData else {
                throw NetworkError.noData
            }
            return try JSONDecoder().decode(T.self, from: data)
        } else {
            throw mockError ?? NetworkError.networkError(URLError(.notConnectedToInternet))
        }
    }
}

class MockCacheService: CacheServiceProtocol {
    private var cachedAPOD: APOD?
    private var cachedImages: [String: UIImage] = [:]
    
    func cacheAPOD(_ apod: APOD) async throws {
        cachedAPOD = apod
    }
    
    func getCachedAPOD() async -> APOD? {
        return cachedAPOD
    }
    
    func cacheImage(_ image: UIImage, for url: String) async throws {
        cachedImages[url] = image
    }
    
    func getCachedImage(for url: String) async -> UIImage? {
        return cachedImages[url]
    }
    
    func clearCache() async throws {
        cachedAPOD = nil
        cachedImages.removeAll()
    }
}

class MockImageService: ImageServiceProtocol {
    var shouldSucceed: Bool = true
    var mockImage: UIImage?
    var mockError: Error?
    
    func loadImage(from url: String) async throws -> UIImage {
        if shouldSucceed {
            return mockImage ?? TestDataFactory.createMockImage()
        } else {
            throw mockError ?? NetworkError.networkError(URLError(.notConnectedToInternet))
        }
    }
    
}

class MockAPODService: APODServiceProtocol {
    var shouldSucceed: Bool = true
    var mockAPOD: APOD?
    var mockError: Error?
    
    func fetchTodaysAPOD() async throws -> APODResult {
        if shouldSucceed {
            let apod = mockAPOD ?? TestDataFactory.createMockAPOD()
            return APODResult(apod: apod, isFromCache: false, isFallbackDate: false)
        } else {
            throw mockError ?? NetworkError.networkError(URLError(.notConnectedToInternet))
        }
    }
    
    func fetchAPOD(for date: Date) async throws -> APODResult {
        if shouldSucceed {
            let apod = mockAPOD ?? TestDataFactory.createMockAPOD()
            return APODResult(apod: apod, isFromCache: false, isFallbackDate: false)
        } else {
            throw mockError ?? NetworkError.networkError(URLError(.notConnectedToInternet))
        }
    }
}
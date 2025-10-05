//
//  TestDataFactory.swift
//  AstroDailyTests
//
//  Created by Hu AN on 01/10/2025.
//

import Foundation
import UIKit
@testable import AstroDaily

class TestDataFactory {
    
    static func createMockAPOD() -> APOD {
        let response = APODResponse(
            date: "2025-01-01",
            title: "Test APOD",
            explanation: "Test explanation",
            url: "https://example.com/test.jpg",
            mediaType: "image",
            hdurl: nil,
            copyright: nil
        )
        return try! APOD(from: response)
    }
    
    static func createMockAPODResult(apod: APOD) -> APODResult {
        return APODResult(apod: apod, isFromCache: false, isFallbackDate: false)
    }
    
    static func createMockJSONData() -> Data {
        let response = APODResponse(
            date: "2025-01-01",
            title: "Test APOD",
            explanation: "Test explanation",
            url: "https://example.com/test.jpg",
            mediaType: "image",
            hdurl: nil,
            copyright: nil
        )
        return try! JSONEncoder().encode(response)
    }
    
    static func createMockImage() -> UIImage {
        let size = CGSize(width: 100, height: 100)
        UIGraphicsBeginImageContext(size)
        UIColor.red.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
    
    static func createMockError() -> Error {
        return NetworkError.networkError(URLError(.notConnectedToInternet))
    }
}
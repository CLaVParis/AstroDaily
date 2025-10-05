//
//  APODModelTests.swift
//  AstroDailyTests
//
//  Created by Hu AN on 05/10/2025.
//

import XCTest
import Foundation
@testable import AstroDaily

final class APODModelTests: XCTestCase {
    
    func testAPODResponseCreation() {
        let response = APODResponse(
            date: "2025-01-01",
            title: "Test APOD",
            explanation: "Test explanation",
            url: "https://example.com/test.jpg",
            mediaType: "image",
            hdurl: nil,
            copyright: nil
        )
        
        XCTAssertEqual(response.date, "2025-01-01")
        XCTAssertEqual(response.title, "Test APOD")
        XCTAssertEqual(response.explanation, "Test explanation")
        XCTAssertEqual(response.url, "https://example.com/test.jpg")
        XCTAssertEqual(response.mediaType, "image")
    }
    
    func testAPODCreation() {
        let testDate = Date()
        let response = APODResponse(
            date: DateFormatter.apodDateFormatter.string(from: testDate),
            title: "Test APOD",
            explanation: "Test explanation",
            url: "https://example.com/test.jpg",
            mediaType: "image",
            hdurl: nil,
            copyright: nil
        )
        
        let apod = try! APOD(from: response)
        
        XCTAssertEqual(apod.title, "Test APOD")
        XCTAssertEqual(apod.explanation, "Test explanation")
        XCTAssertEqual(apod.mediaType, APODMediaType.image)
        XCTAssertNotNil(apod.url)
    }
    
    func testAPODMediaType() {
        XCTAssertEqual(APODMediaType.image.rawValue, "image")
        XCTAssertEqual(APODMediaType.video.rawValue, "video")
        
        XCTAssertEqual(APODMediaType.image.displayName, "Image")
        XCTAssertEqual(APODMediaType.video.displayName, "Video")
    }
    
    func testAPODResultCreation() {
        let mockAPOD = TestDataFactory.createMockAPOD()
        let result = APODResult(apod: mockAPOD, isFromCache: false, isFallbackDate: false)
        
        XCTAssertEqual(result.apod.title, mockAPOD.title)
        XCTAssertFalse(result.isFromCache)
        XCTAssertFalse(result.isFallbackDate)
    }
}

//
//  TestDataFactoryTests.swift
//  AstroDailyTests
//
//  Created by Hu AN on 05/10/2025.
//

import XCTest
import UIKit
@testable import AstroDaily

final class TestDataFactoryTests: XCTestCase {
    
    func testCreateMockAPOD() {
        let mockAPOD = TestDataFactory.createMockAPOD()
        
        XCTAssertEqual(mockAPOD.title, "Test APOD")
        XCTAssertEqual(mockAPOD.explanation, "Test explanation")
        XCTAssertEqual(mockAPOD.mediaType, APODMediaType.image)
    }
    
    func testCreateMockAPODResult() {
        let mockAPOD = TestDataFactory.createMockAPOD()
        let result = TestDataFactory.createMockAPODResult(apod: mockAPOD)
        
        XCTAssertEqual(result.apod.title, mockAPOD.title)
        XCTAssertFalse(result.isFromCache)
        XCTAssertFalse(result.isFallbackDate)
    }
    
    func testCreateMockJSONData() {
        let mockData = TestDataFactory.createMockJSONData()
        
        XCTAssertFalse(mockData.isEmpty)
        
        do {
            let response = try JSONDecoder().decode(APODResponse.self, from: mockData)
            XCTAssertEqual(response.title, "Test APOD")
        } catch {
            XCTFail("Failed to decode mock JSON data: \(error)")
        }
    }
    
    func testCreateMockImage() {
        let mockImage = TestDataFactory.createMockImage()
        
        XCTAssertNotNil(mockImage)
        XCTAssertTrue(mockImage.size.width > 0)
        XCTAssertTrue(mockImage.size.height > 0)
    }
    
    func testCreateMockError() {
        let mockError = TestDataFactory.createMockError()
        
        XCTAssertTrue(mockError is NetworkError)
    }
}

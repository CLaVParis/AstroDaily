//
//  MockServicesTests.swift
//  AstroDailyTests
//
//  Created by Hu AN on 05/10/2025.
//

import XCTest
@testable import AstroDaily

final class MockServicesTests: XCTestCase {
    
    func testMockNetworkService() {
        let mockService = MockNetworkService()
        
        XCTAssertTrue(mockService.shouldSucceed)
        XCTAssertEqual(mockService.requestCount, 0)
        XCTAssertNil(mockService.mockData)
        XCTAssertNil(mockService.mockError)
    }
    
    func testMockCacheService() {
        let mockService = MockCacheService()
        XCTAssertNotNil(mockService)
    }
    
    func testMockImageService() {
        let mockService = MockImageService()
        
        XCTAssertTrue(mockService.shouldSucceed)
        XCTAssertNil(mockService.mockImage)
        XCTAssertNil(mockService.mockError)
    }
    
    func testMockAPODService() {
        let mockService = MockAPODService()
        
        XCTAssertTrue(mockService.shouldSucceed)
        XCTAssertNil(mockService.mockAPOD)
        XCTAssertNil(mockService.mockError)
    }
}

//
//  NetworkModelTests.swift
//  AstroDailyTests
//
//  Created by Hu AN on 05/10/2025.
//

import XCTest
import Foundation
@testable import AstroDaily

final class NetworkModelTests: XCTestCase {
    
    func testNetworkErrorTypes() {
        
        let invalidURLError = NetworkError.invalidURL
        let noDataError = NetworkError.noData
        let decodingError = NetworkError.decodingError(NSError(domain: "Test", code: 0, userInfo: nil))
        let serverError = NetworkError.serverError(404)
        let networkError = NetworkError.networkError(URLError(.notConnectedToInternet))
        
        XCTAssertNotNil(invalidURLError.errorDescription)
        XCTAssertNotNil(noDataError.errorDescription)
        XCTAssertNotNil(decodingError.errorDescription)
        XCTAssertNotNil(serverError.errorDescription)
        XCTAssertNotNil(networkError.errorDescription)
    }
    
    func testAPIConfiguration() {
        XCTAssertNotNil(APIConfiguration.baseURL)
        XCTAssertEqual(APIConfiguration.timeoutInterval, 30.0)
        XCTAssertTrue(APIConfiguration.apodURL.contains("/v1/apod"))
    }
}

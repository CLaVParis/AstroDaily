//
//  ErrorHandlerTests.swift
//  AstroDailyTests
//
//  Created by Hu AN on 05/10/2025.
//

import XCTest
@testable import AstroDaily

final class ErrorHandlerTests: XCTestCase {
    
    func testErrorHandlerInitialization() {
        let handler = ErrorHandler.shared
        XCTAssertNotNil(handler)
    }
    
    func testErrorHandlerSingleton() {
        let handler1 = ErrorHandler.shared
        let handler2 = ErrorHandler.shared
        
        XCTAssertTrue(handler1 === handler2)
    }
}

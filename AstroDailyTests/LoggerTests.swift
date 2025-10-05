//
//  LoggerTests.swift
//  AstroDailyTests
//
//  Created by Hu AN on 05/10/2025.
//

import XCTest
@testable import AstroDaily

final class LoggerTests: XCTestCase {
    
    func testLoggerInitialization() {
        let logger = Logger.shared
        XCTAssertNotNil(logger)
    }
    
    func testLoggerMethods() {
        let logger = Logger.shared
        
        logger.debug("Debug message", file: #file, function: #function, line: #line)
        logger.info("Info message", file: #file, function: #function, line: #line)
        logger.error("Error message", file: #file, function: #function, line: #line)
        
        XCTAssertTrue(true)
    }
    
    func testLoggerPerformance() {
        measure {
            for i in 0..<100 {
                Logger.shared.info("Performance test \(i)", file: #file, function: #function, line: #line)
            }
        }
    }
}

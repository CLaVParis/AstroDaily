//
//  UtilityTests.swift
//  AstroDailyTests
//
//  Created by Hu AN on 05/10/2025.
//

import XCTest
import Foundation
@testable import AstroDaily

final class UtilityTests: XCTestCase {
    
    func testDateFormatter() {
        let formatter = DateFormatter.apodDateFormatter
        let date = Date()
        let formatted = formatter.string(from: date)
        
        XCTAssertFalse(formatted.isEmpty)
        XCTAssertEqual(formatted.count, 10) 
        
        let components = formatted.components(separatedBy: "-")
        XCTAssertEqual(components.count, 3)
        XCTAssertEqual(components[0].count, 4)
        XCTAssertEqual(components[1].count, 2)
        XCTAssertEqual(components[2].count, 2)
    }
}

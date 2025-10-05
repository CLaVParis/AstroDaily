//
//  ThemeTests.swift
//  AstroDailyTests
//
//  Created by Hu AN on 05/10/2025.
//

import XCTest
import SwiftUI
@testable import AstroDaily

final class ThemeTests: XCTestCase {
    
    func testColorTheme() {
        let primaryColor = ColorTheme.primaryText
        let backgroundColor = ColorTheme.videoBackground
        let primaryAccent = ColorTheme.primary
        
        XCTAssertNotNil(primaryColor)
        XCTAssertNotNil(backgroundColor)
        XCTAssertNotNil(primaryAccent)
    }
    
    func testFontTheme() {
        let titleFont = FontTheme.title
        let bodyFont = FontTheme.body
        let captionFont = FontTheme.caption
        
        XCTAssertNotNil(titleFont)
        XCTAssertNotNil(bodyFont)
        XCTAssertNotNil(captionFont)
    }
}

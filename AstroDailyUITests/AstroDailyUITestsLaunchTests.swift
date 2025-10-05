//
//  AstroDailyUITestsLaunchTests.swift
//  AstroDailyUITests
//
//  Created by Hu AN on 01/10/2025.
//

import XCTest

final class AstroDailyUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        false
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunchScreen() throws {
        let app = XCUIApplication()
        
        app.launchArguments = ["-UI_TESTING"]
        app.launchEnvironment = [
            "UITEST_DISABLE_ANIMATIONS": "1"
        ]
        
        app.launch()

        let exists = app.wait(for: .runningForeground, timeout: 5.0)
        XCTAssertTrue(exists)
        
        app.terminate()
    }
    
    @MainActor
    func testDateSelectorExists() throws {
        let app = XCUIApplication()
        
        app.launchArguments = ["-UI_TESTING"]
        app.launchEnvironment = [
            "UITEST_DISABLE_ANIMATIONS": "1"
        ]
        
        app.launch()

        let exists = app.wait(for: .runningForeground, timeout: 5.0)
        XCTAssertTrue(exists)
        
        let dateButton = app.buttons.firstMatch
        XCTAssertTrue(dateButton.waitForExistence(timeout: 3.0))
        
        app.terminate()
    }
    
    @MainActor
    func testScrollViewExists() throws {
        let app = XCUIApplication()
        
        app.launchArguments = ["-UI_TESTING"]
        app.launchEnvironment = [
            "UITEST_DISABLE_ANIMATIONS": "1"
        ]
        
        app.launch()

        let exists = app.wait(for: .runningForeground, timeout: 5.0)
        XCTAssertTrue(exists)
        
        let scrollView = app.scrollViews.firstMatch
        XCTAssertTrue(scrollView.waitForExistence(timeout: 3.0))
        
        app.terminate()
    }
}

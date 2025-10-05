//
//  AstroDailyUITests.swift
//  AstroDailyUITests
//
//  Created by Hu AN on 01/10/2025.
//

import XCTest

final class AstroDailyUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    @MainActor
    func testAppLaunches() throws {
        let app = XCUIApplication()
        
        app.launchArguments = [
            "-UI_TESTING",
            "-disable-system-apps"
        ]
        app.launchEnvironment = [
            "UITEST_DISABLE_ANIMATIONS": "1",
            "UITEST_DISABLE_SYSTEM_APPS": "1",
            "SIMULATOR_DISABLE_SYSTEM_APPS": "1"
        ]
        
        app.launch()
        
        Thread.sleep(forTimeInterval: 1.0)
        
        XCTAssertTrue(app.state == .runningForeground)
        
        app.terminate()
    }
}

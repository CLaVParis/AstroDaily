//
//  APODContentUITests.swift
//  AstroDailyUITests
//
//  Created by Hu AN on 01/10/2025.
//

import XCTest

final class APODContentUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app = XCUIApplication()
        
        // Extreme isolation to prevent system app interference
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
        
        // Minimal wait without complex expectations
        Thread.sleep(forTimeInterval: 1.0)
    }

    override func tearDownWithError() throws {
        if app.state == .runningForeground {
            app.terminate()
        }
        app = nil
    }

    @MainActor
    func testAppLaunchesSuccessfully() throws {
        XCTAssertTrue(app.state == .runningForeground)
    }
}


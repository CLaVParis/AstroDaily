//
//  NavigationUITests.swift
//  AstroDailyUITests
//
//  Created by Hu AN on 01/10/2025.
//

import XCTest

final class NavigationUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app = XCUIApplication()
        
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
    }

    override func tearDownWithError() throws {
        if app.state == .runningForeground {
            app.terminate()
        }
        app = nil
    }

    @MainActor
    func testAppLaunchesWithoutCrash() throws {
        XCTAssertTrue(app.state == .runningForeground)
    }
}

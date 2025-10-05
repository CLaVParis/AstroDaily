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

    @MainActor
    func testLaunchStability() throws {
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

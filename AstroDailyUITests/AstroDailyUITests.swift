//
//  AstroDailyUITests.swift
//  AstroDailyUITests
//
//  Created by Hu AN on 01/10/2025.
//

import XCTest

final class AstroDailyUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        
        // Minimal configuration to avoid system conflicts
        app.launchArguments = ["-UI_TESTING"]
        app.launchEnvironment = [
            "UITEST_DISABLE_ANIMATIONS": "1"
        ]
    }

    override func tearDownWithError() throws {
        if app.state == .runningForeground {
            app.terminate()
        }
        app = nil
    }

    @MainActor
    func testAppLaunches() throws {
        app.launch()
        
        let exists = app.wait(for: .runningForeground, timeout: 5.0)
        XCTAssertTrue(exists)
    }
    
    @MainActor
    func testMainTabViewExists() throws {
        app.launch()
        
        let exists = app.wait(for: .runningForeground, timeout: 5.0)
        XCTAssertTrue(exists)
        
        let tabView = app.tabBars.firstMatch
        XCTAssertTrue(tabView.waitForExistence(timeout: 3.0))
    }
    
    @MainActor
    func testAPODTabExists() throws {
        app.launch()
        
        let exists = app.wait(for: .runningForeground, timeout: 5.0)
        XCTAssertTrue(exists)
        
        let apodTab = app.tabBars.buttons.firstMatch
        XCTAssertTrue(apodTab.waitForExistence(timeout: 3.0))
    }
    
    @MainActor
    func testHistoryTabExists() throws {
        app.launch()
        
        let exists = app.wait(for: .runningForeground, timeout: 5.0)
        XCTAssertTrue(exists)
        
        let historyTab = app.tabBars.buttons.element(boundBy: 1)
        XCTAssertTrue(historyTab.waitForExistence(timeout: 3.0))
    }
    
    @MainActor
    func testTabNavigation() throws {
        app.launch()
        
        let exists = app.wait(for: .runningForeground, timeout: 5.0)
        XCTAssertTrue(exists)
        
        let historyTab = app.tabBars.buttons.element(boundBy: 1)
        if historyTab.waitForExistence(timeout: 3.0) {
            historyTab.tap()
            
            Thread.sleep(forTimeInterval: 0.5)
            
            XCTAssertTrue(app.state == .runningForeground)
        }
    }
}

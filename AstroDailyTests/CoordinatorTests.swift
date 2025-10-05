//
//  CoordinatorTests.swift
//  AstroDailyTests
//
//  Created by Hu AN on 01/10/2025.
//

import XCTest
import SwiftUI
@testable import AstroDaily

final class CoordinatorTests: XCTestCase {
    
    private var coordinator: AppCoordinator!
    
    override func setUp() {
        super.setUp()
        coordinator = AppCoordinator()
    }
    
    override func tearDown() {
        coordinator = nil
        super.tearDown()
    }
    
    // MARK: - Initialization Tests
    
    func testAppCoordinatorInitialization() {
        XCTAssertNotNil(coordinator)
        XCTAssertTrue(coordinator.path.isEmpty)
        XCTAssertNil(coordinator.presentedSheet)
        XCTAssertFalse(coordinator.isSheetPresented)
    }
    
    // MARK: - Navigation Tests
    
    func testNavigateToRoute() {
        let testRoute = "testRoute"
        
        coordinator.navigate(to: testRoute)
        
        XCTAssertFalse(coordinator.path.isEmpty)
    }
    
    func testPopToRoot() {
        // Add some routes first
        coordinator.navigate(to: "route1")
        coordinator.navigate(to: "route2")
        
        XCTAssertFalse(coordinator.path.isEmpty)
        
        coordinator.popToRoot()
        
        XCTAssertTrue(coordinator.path.isEmpty)
    }
    
    // MARK: - Sheet Presentation Tests
    
    func testPresentSheet() {
        let testView = Text("Test View")
        
        coordinator.presentSheet(testView)
        
        XCTAssertNotNil(coordinator.presentedSheet)
        XCTAssertTrue(coordinator.isSheetPresented)
    }
    
    func testDismissSheet() {
        // Present a sheet first
        let testView = Text("Test View")
        coordinator.presentSheet(testView)
        
        XCTAssertTrue(coordinator.isSheetPresented)
        
        // Dismiss the sheet
        coordinator.dismissSheet()
        
        XCTAssertNil(coordinator.presentedSheet)
        XCTAssertFalse(coordinator.isSheetPresented)
    }
    
    // MARK: - APOD Coordinator Tests
    
    func testAPODCoordinatorInitialization() {
        let viewModel = APODViewModel()
        let apodCoordinator = APODCoordinator(viewModel: viewModel)
        
        XCTAssertNotNil(apodCoordinator)
        XCTAssertTrue(apodCoordinator.path.isEmpty)
        XCTAssertNil(apodCoordinator.presentedSheet)
        XCTAssertFalse(apodCoordinator.isSheetPresented)
    }
    
    func testShowDatePicker() {
        let viewModel = APODViewModel()
        let apodCoordinator = APODCoordinator(viewModel: viewModel)
        
        apodCoordinator.showDatePicker()
        
        XCTAssertTrue(apodCoordinator.isSheetPresented)
        XCTAssertNotNil(apodCoordinator.presentedSheet)
    }
    
    // MARK: - Environment Key Tests
    
    func testCoordinatorEnvironmentKey() {
        let key = CoordinatorEnvironmentKey.self
        let defaultValue = key.defaultValue
        
        XCTAssertNotNil(defaultValue)
        XCTAssertTrue(type(of: defaultValue) == AppCoordinator.self)
    }
}

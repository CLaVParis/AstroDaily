//
//  DIContainerTests.swift
//  AstroDailyTests
//
//  Created by Hu AN on 05/10/2025.
//

import XCTest
@testable import AstroDaily

final class DIContainerTests: XCTestCase {
    
    private var container: DIContainer!
    
    override func setUp() {
        super.setUp()
        container = DIContainer.shared
    }
    
    func testDIContainerInitialization() {
        XCTAssertNotNil(container)
    }
    
    func testDIContainerSingleton() {
        let container1 = DIContainer.shared
        let container2 = DIContainer.shared
        
        XCTAssertTrue(container1 === container2)
    }
    
    func testServiceRegistration() {
        
        container.register(String.self) { "test string" }
        
        let result = container.resolve(String.self)
        XCTAssertEqual(result, "test string")
    }
    
    func testSingletonRegistration() {
        
        container.registerSingleton(Int.self) { 42 }
        
        let result1 = container.resolve(Int.self)
        let result2 = container.resolve(Int.self)
        XCTAssertEqual(result1, result2)
        XCTAssertEqual(result1, 42)
    }
}

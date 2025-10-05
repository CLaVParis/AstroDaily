//
//  APODViewModelTests.swift
//  AstroDailyTests
//
//  Created by Hu AN on 05/10/2025.
//

import XCTest
@testable import AstroDaily

final class APODViewModelTests: XCTestCase {
    
    private var viewModel: APODViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = APODViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testInitialState() {
        
        if case .empty = viewModel.state {
            XCTAssertTrue(true)
        } else {
            XCTFail("Expected empty state")
        }
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testAPODViewState() {
        // Test all possible view states
        let testAPOD = TestDataFactory.createMockAPOD()
        let loadingState = APODViewState.loading
        let loadedState = APODViewState.loaded(testAPOD, isFallbackDate: false, isFromCache: false)
        let errorState = APODViewState.error(NetworkError.networkError(URLError(.notConnectedToInternet)))
        let emptyState = APODViewState.empty
        
        if case .loading = loadingState { XCTAssertTrue(true) } else { XCTFail("Expected loading state") }
        if case .loaded(let apod, _, _) = loadedState { XCTAssertEqual(apod.title, testAPOD.title) } else { XCTFail("Expected loaded state") }
        if case .error(let error) = errorState { XCTAssertTrue(error is NetworkError) } else { XCTFail("Expected error state") }
        if case .empty = emptyState { XCTAssertTrue(true) } else { XCTFail("Expected empty state") }
    }
}

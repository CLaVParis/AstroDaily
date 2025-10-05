//
//  AstroDailyTests.swift
//  AstroDailyTests
//
//  Created by Hu AN on 01/10/2025.
//

import Testing
import Foundation
import SwiftUI
@testable import AstroDaily

struct AstroDailyTests {

    @Test func testAppInitialization() async throws {
    
        let app = await AstroDailyApp()
        
        #expect(app != nil)
    }
    
    @Test func testContentViewInitialization() async throws {
        
        let contentView = await ContentView()
        
        #expect(contentView != nil)
    }
    
    @Test func testMainTabViewInitialization() async throws {
        
        let mainTabView = await MainTabView()
        
        #expect(mainTabView != nil)
    }
    
    @Test func testAPODContentViewInitialization() async throws {
       
        let apodContentView = await APODContentView()
        
        #expect(apodContentView != nil)
    }
    
    @Test func testDatePickerViewInitialization() async throws {
        
        let selectedDate = Date()
        let isPresented = false
        let onDateSelected: (Date) -> Void = { _ in }
        
        let datePickerView = await DatePickerView(
            selectedDate: .constant(selectedDate),
            isPresented: .constant(isPresented),
            onDateSelected: onDateSelected
        )
        
        #expect(datePickerView != nil)
    }
    
    @Test func testColorThemeInitialization() async throws {
        
        let primaryText = ColorTheme.primaryText
        let secondaryText = ColorTheme.secondaryText
        let primaryBackground = ColorTheme.videoBackground
        let secondaryBackground = ColorTheme.secondaryBackground
        
        #expect(primaryText != nil)
        #expect(secondaryText != nil)
        #expect(primaryBackground != nil)
        #expect(secondaryBackground != nil)
    }
    
    @Test func testFontThemeInitialization() async throws {
        
        let largeTitle = FontTheme.largeTitle
        let title = FontTheme.title
        let body = FontTheme.body
        
        #expect(largeTitle != nil)
        #expect(title != nil)
        #expect(body != nil)
    }
    
    @Test func testLoggerInitialization() async throws {
        
        let logger = Logger.shared
        
        #expect(logger != nil)
    }
    
    @Test func testErrorHandlerInitialization() async throws {
        
        let errorHandler = ErrorHandler.shared
        
        #expect(errorHandler != nil)
    }
    
    @Test func testDIContainerInitialization() async throws {
        let container = DIContainer.shared
        
        #expect(container != nil)
    }
}

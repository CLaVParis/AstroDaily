//
//  AstroDailyApp.swift
//  AstroDaily
//
//  Created by Hu AN on 01/10/2025.
//

import SwiftUI

@main
struct AstroDailyApp: App {
    init() {
        setupApplication()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .withErrorHandling()
        }
    }
    
    private func setupApplication() {
        // Initialize dependency injection
        ServiceRegistry.registerAllServices()
        
        logInfo("AstroDaily application initialized with DI")
    }
}

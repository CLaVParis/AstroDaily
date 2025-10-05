//
//  ErrorHandler.swift
//  AstroDaily
//
//  Created by Hu AN on 01/10/2025.
//

import Foundation
import SwiftUI

// MARK: - App Error Implementation
struct AppError: AppErrorProtocol {
    let errorCode: String
    let userMessage: String
    let technicalMessage: String
    let recoverySuggestionText: String?
    let underlyingError: Error?
    
    init(
        errorCode: String,
        userMessage: String,
        technicalMessage: String,
        recoverySuggestionText: String? = nil,
        underlyingError: Error? = nil
    ) {
        self.errorCode = errorCode
        self.userMessage = userMessage
        self.technicalMessage = technicalMessage
        self.recoverySuggestionText = recoverySuggestionText
        self.underlyingError = underlyingError
    }
    
    var errorDescription: String? {
        return userMessage
    }
    
    var failureReason: String? {
        return technicalMessage
    }
    
    var recoverySuggestion: String? {
        return recoverySuggestionText
    }
}


// MARK: - Error Handler
final class ErrorHandler: ObservableObject {
    static let shared = ErrorHandler()
    
    @Published var currentError: AppError?
    @Published var isShowingError = false
    
    private let logger = Logger.shared
    
    private init() {}
    
    
    
    func dismissError() {
        DispatchQueue.main.async {
            self.isShowingError = false
            self.currentError = nil
        }
    }
}


// MARK: - Error Handler View Modifier
struct ErrorHandlerModifier: ViewModifier {
    @StateObject private var errorHandler = ErrorHandler.shared
    
    func body(content: Content) -> some View {
        content
            .alert("Error", isPresented: $errorHandler.isShowingError) {
                Button("OK") {
                    errorHandler.dismissError()
                }
            } message: {
                if errorHandler.currentError != nil {
                    Text(errorHandler.currentError?.userMessage ?? "")
                }
            }
    }
}

extension View {
    func withErrorHandling() -> some View {
        self.modifier(ErrorHandlerModifier())
    }
}

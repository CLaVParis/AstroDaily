//
//  AppErrorProtocol.swift
//  AstroDaily
//
//  Created by Hu AN on 04/10/2025.
//

import Foundation
import SwiftUI

// MARK: - App Error Protocol
protocol AppErrorProtocol: Error, LocalizedError {
    var errorCode: String { get }
    var userMessage: String { get }
    var technicalMessage: String { get }
    var recoverySuggestion: String? { get }
    var underlyingError: Error? { get }
}


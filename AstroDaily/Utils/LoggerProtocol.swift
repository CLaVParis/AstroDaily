//
//  LoggerProtocol.swift
//  AstroDaily
//
//  Created by Hu AN on 04/10/2025.
//

import Foundation

// MARK: - Logger Protocol
protocol LoggerProtocol {
    func log(_ level: LogLevel, _ message: String, file: String, function: String, line: Int)
    func debug(_ message: String, file: String, function: String, line: Int)
    func info(_ message: String, file: String, function: String, line: Int)
    func error(_ message: String, file: String, function: String, line: Int)
}




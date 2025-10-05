//
//  Logger.swift
//  AstroDaily
//
//  Created by Hu AN on 01/10/2025.
//

import Foundation
import OSLog

// MARK: - Log Level
enum LogLevel: String, CaseIterable {
    case debug = "DEBUG"
    case info = "INFO"
    case error = "ERROR"
    
    var osLogLevel: OSLogType {
        switch self {
        case .debug:
            return .debug
        case .info:
            return .info
        case .error:
            return .error
        }
    }
}

// MARK: - Logger Implementation
final class Logger: LoggerProtocol {
    static let shared = Logger()
    
    private let osLogger: OSLog
    private let isDebugBuild: Bool
    
    private init() {
        self.osLogger = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "AstroDaily", category: "AstroDaily")
        #if DEBUG
        self.isDebugBuild = true
        #else
        self.isDebugBuild = false
        #endif
    }
    
    func log(_ level: LogLevel, _ message: String, file: String, function: String, line: Int) {
        let fileName = (file as NSString).lastPathComponent
        let logMessage = "[\(level.rawValue)] \(fileName):\(line) \(function) - \(message)"
        
        // Also output to console in Debug mode
        if isDebugBuild {
            print(logMessage)
        }
        
        // Use OSLog to record to system log
        os_log("%{public}@", log: osLogger, type: level.osLogLevel, logMessage)
    }
    
    func debug(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(.debug, message, file: file, function: function, line: line)
    }
    
    func info(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(.info, message, file: file, function: function, line: line)
    }
    
    
    func error(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(.error, message, file: file, function: function, line: line)
    }
}

// MARK: - Global Logging Functions
func logDebug(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
    Logger.shared.debug(message, file: file, function: function, line: line)
}

func logInfo(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
    Logger.shared.info(message, file: file, function: function, line: line)
}


func logError(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
    Logger.shared.error(message, file: file, function: function, line: line)
}



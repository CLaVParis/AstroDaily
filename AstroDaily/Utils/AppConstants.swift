//
//  AppConstants.swift
//  AstroDaily
//
//  Created by Hu AN on 01/10/2025.
//

import Foundation

// MARK: - HTTP Status Codes
struct HTTPStatusCodes {
    static let successRange = 200...299
    static let notFound = 404
    static let noContent = 204
    static let unprocessableEntity = 422
    static let noContentStatusCodes = [notFound, noContent, unprocessableEntity]
}

// MARK: - APOD Date Constants
struct APODDateConstants {
    static let startYear = 1995
    static let startMonth = 6
    static let startDay = 16
    static let fallbackYear = 2000
    static let fallbackMonth = 1
    static let fallbackDay = 1
}

// MARK: - Video ID Validation Constants
struct VideoIdConstants {
    static let minLength = 6
    static let maxLength = 20
}

// MARK: - UI Dimension Constants
struct UIConstants {
    static let videoPlayerHeight: CGFloat = 200
    static let cornerRadius: CGFloat = 12
    static let largeCornerRadius: CGFloat = 20
    static let spacing: CGFloat = 20
    static let mediumSpacing: CGFloat = 16
    static let smallSpacing: CGFloat = 12
    static let horizontalPadding: CGFloat = 16
    static let verticalPadding: CGFloat = 12
    static let largeFontSize: CGFloat = 60
    static let mediumFontSize: CGFloat = 50
    static let smallFontSize: CGFloat = 40
    static let tabletBreakpoint: CGFloat = 600
    static let tabletFontSize: CGFloat = 60
    static let phoneFontSize: CGFloat = 50
    static let tabletPadding: CGFloat = 40
    static let phonePadding: CGFloat = 20
    static let tabletScale: CGFloat = 1.1
    static let phoneScale: CGFloat = 1.0
    static let minSpacerLength: CGFloat = 20
}

// MARK: - Network Constants
struct NetworkConstants {
    static let timeoutInterval: TimeInterval = 30.0
}


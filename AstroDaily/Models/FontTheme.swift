//
//  FontTheme.swift
//  AstroDaily
//
//  Created by Hu AN on 01/10/2025.
//

import SwiftUI

// MARK: - Font Theme
struct FontTheme {
    static let largeTitle = Font.largeTitle.weight(.bold)
    
    static let title = Font.title.weight(.semibold)
    
    static let title2 = Font.title2.weight(.semibold)
    
    static let title3 = Font.title3.weight(.medium)
    
    static let headline = Font.headline.weight(.medium)
    
    static let subheadline = Font.subheadline.weight(.medium)
    
    static let body = Font.body
    
    static let callout = Font.callout
    
    static let footnote = Font.footnote
    
    static let caption = Font.caption
    
    static let caption2 = Font.caption2
}


// MARK: - Accessibility Extensions
extension View {
    
    func standardFontSize() -> some View {
        self.dynamicTypeSize(.medium)
    }
}

// MARK: - Font Style Helpers
extension FontTheme {
    
    static func style(for contentType: ContentType) -> Font {
        switch contentType {
        case .pageTitle:
            return largeTitle
        case .sectionTitle:
            return title2
        case .cardTitle:
            return headline
        case .bodyText:
            return body
        case .caption:
            return caption
        case .button:
            return callout.weight(.medium)
        case .navigationTitle:
            return title.weight(.semibold)
        case .callout:
            return callout
        case .title3:
            return title3
        }
    }
}

// MARK: - Content Type Enum
enum ContentType {
    case pageTitle
    case sectionTitle
    case cardTitle
    case bodyText
    case caption
    case button
    case navigationTitle
    case callout
    case title3
}

//
//  ErrorView.swift
//  AstroDaily
//
//  Created by Hu AN on 01/10/2025.
//

import SwiftUI

// MARK: - Error View
struct ErrorView: View {
    let error: Error
    let retryAction: () -> Void
    
    private var errorIcon: String {
        if let networkError = error as? NetworkError {
            switch networkError {
            case .dateOutOfRange, .invalidDate:
                return "calendar.badge.exclamationmark"
            case .networkError:
                return "wifi.slash"
            case .serverError:
                return "server.rack"
            default:
                return "exclamationmark.triangle"
            }
        }
        return "exclamationmark.triangle"
    }
    
    private var errorTitle: String {
        if let networkError = error as? NetworkError {
            switch networkError {
            case .dateOutOfRange, .invalidDate:
                return "Date Error"
            case .networkError:
                return "Network Connection Issue"
            case .serverError:
                return "Server Error"
            default:
                return "Error Occurred"
            }
        }
        return "Error Occurred"
    }
    
    var body: some View {
        VStack(spacing: UIConstants.mediumSpacing) {
            Image(systemName: errorIcon)
                .font(.system(size: UIConstants.mediumFontSize))
                .foregroundColor(ColorTheme.warning)
            
            Text(errorTitle)
                .font(FontTheme.style(for: .sectionTitle))
                .foregroundColor(ColorTheme.primaryText)
            
            Text(error.localizedDescription)
                .font(FontTheme.style(for: .bodyText))
                .foregroundColor(ColorTheme.secondaryText)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button("Retry") {
                retryAction()
            }
            .buttonStyle(.borderedProminent)
            .accessibilityLabel("Retry loading APOD content")
            .accessibilityHint("Tap to retry loading astronomy picture")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

#Preview {
    ErrorView(error: NetworkError.networkError(NSError(domain: "Test", code: 0)), retryAction: {})
}

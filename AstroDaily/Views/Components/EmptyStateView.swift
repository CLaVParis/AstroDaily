//
//  EmptyStateView.swift
//  AstroDaily
//
//  Created by Hu AN on 01/10/2025.
//

import SwiftUI

// MARK: - Empty State View
struct EmptyStateView: View {
    let loadAction: () -> Void
    
    var body: some View {
        VStack(spacing: UIConstants.mediumSpacing) {
            Image(systemName: "sparkles")
                .font(.system(size: UIConstants.mediumFontSize))
                .foregroundColor(.blue)
            
            Text("Welcome to AstroDaily")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Explore the universe, discover NASA's daily astronomy pictures")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button("Load Today's APOD") {
                loadAction()
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

#Preview {
    EmptyStateView(loadAction: {})
}

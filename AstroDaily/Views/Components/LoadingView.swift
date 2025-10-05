//
//  LoadingView.swift
//  AstroDaily
//
//  Created by Hu AN on 01/10/2025.
//

import SwiftUI

// MARK: - Loading View
struct LoadingView: View {
    var body: some View {
        VStack(spacing: UIConstants.mediumSpacing) {
            ProgressView()
                .scaleEffect(1.5)
            
            VStack(spacing: 8) {
                Text("Loading APOD...")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text("Please wait, fetching astronomy picture")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

#Preview {
    LoadingView()
}

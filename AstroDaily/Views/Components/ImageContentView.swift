//
//  ImageContentView.swift
//  AstroDaily
//
//  Created by Hu AN on 01/10/2025.
//

import SwiftUI

// MARK: - Image Content View
struct ImageContentView: View {
    let imageURL: String
    @State private var image: UIImage?
    @State private var isLoading = true
    
    var body: some View {
        ZStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .accessibilityLabel("Astronomy picture of the day")
                    .accessibilityAddTraits(.isImage)
            } else if isLoading {
                ProgressView("Loading image...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(ColorTheme.tertiaryBackground)
            } else {
                VStack(spacing: UIConstants.smallSpacing) {
                    Image(systemName: "photo")
                        .font(.system(size: UIConstants.smallFontSize))
                        .foregroundColor(.secondary)
                    
                    Text("Failed to load image")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(ColorTheme.tertiaryBackground)
            }
        }
        .onAppear {
            loadImage()
        }
    }
    
    private func loadImage() {
        Task {
            do {
                let imageService = ImageService()
                let loadedImage = try await imageService.loadImage(from: imageURL)
                await MainActor.run {
                    self.image = loadedImage
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.isLoading = false
                }
                logError("Failed to load image: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    ImageContentView(imageURL: "https://example.com/image.jpg")
        .frame(height: UIConstants.videoPlayerHeight)
}

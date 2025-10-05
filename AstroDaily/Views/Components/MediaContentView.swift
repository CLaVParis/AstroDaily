//
//  MediaContentView.swift
//  AstroDaily
//
//  Created by Hu AN on 01/10/2025.
//

import SwiftUI

// MARK: - Media Content View
struct MediaContentView: View {
    let apod: APOD
    
    var body: some View {
        VStack(spacing: 0) {
            if apod.mediaType == .image {
                ImageContentView(imageURL: apod.url.absoluteString)
            } else {
                UniversalVideoPlayer(
                    videoURL: apod.url,
                    title: apod.title
                )
            }
        }
        .background(ColorTheme.secondaryBackground)
        .cornerRadius(UIConstants.cornerRadius)
    }
}

#Preview {
    let sampleAPOD = APOD(
        id: "preview",
        date: Date(),
        title: "Sample APOD",
        explanation: "This is a sample explanation of the Astronomy Picture of the Day.",
        mediaType: .image,
        url: URL(string: "https://example.com/image.jpg")!,
        hdurl: URL(string: "https://example.com/image_hd.jpg"),
        copyright: "Sample Copyright"
    )
    
    MediaContentView(apod: sampleAPOD)
        .padding()
}

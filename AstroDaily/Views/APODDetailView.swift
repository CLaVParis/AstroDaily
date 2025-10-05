//
//  APODDetailView.swift
//  AstroDaily
//
//  Created by Hu AN on 01/10/2025.
//

import SwiftUI

// MARK: - APOD Detail View
struct APODDetailView: View {
    let apod: APOD
    @State private var showingFullScreenVideo = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: UIConstants.mediumSpacing) {
            VStack(alignment: .leading, spacing: 8) {
                Text(DateFormatter.displayDateFormatter.string(from: apod.date))
                    .font(.caption)
                    .foregroundColor(ColorTheme.secondaryText)
                
                Text(apod.title)
                    .font(FontTheme.style(for: .sectionTitle))
                    .foregroundColor(ColorTheme.primaryText)
                    .multilineTextAlignment(.leading)
            }
            
            MediaContentView(apod: apod)
            
            if let copyright = apod.copyright {
                Text("© \(copyright)")
                    .font(FontTheme.style(for: .caption))
                    .foregroundColor(ColorTheme.secondaryText)
                    .italic()
            }
            
            Text(apod.explanation)
                .font(FontTheme.style(for: .bodyText))
                .foregroundColor(ColorTheme.primaryText)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
    }
}

#Preview {
    let sampleAPOD = APOD(
        id: "preview",
        date: Date(),
        title: "Sample APOD",
        explanation: "This is a sample explanation of the Astronomy Picture of the Day. It contains detailed information about the celestial object or phenomenon shown in the image.",
        mediaType: .image,
        url: URL(string: "https://apod.nasa.gov/apod/image/placeholder.jpg")!,
        hdurl: URL(string: "https://apod.nasa.gov/apod/image/placeholder.jpg"),
        copyright: "Sample Copyright"
    )
    
    APODDetailView(apod: sampleAPOD)
        .padding()
}

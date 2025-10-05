//
//  ImageService.swift
//  AstroDaily
//
//  Created by Hu AN on 01/10/2025.
//

import Foundation
import UIKit

// MARK: - Image Processing Constants
private struct ImageConstants {
    static let maxImageSizeBytes = 50 * 1024 * 1024 // 50MB
    static let maxImageDimension: CGFloat = 2048
}

// MARK: - UIImage Extension for Resizing
extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

// MARK: - Image Service Implementation
class ImageService: ImageServiceProtocol {
    @Injected(CacheServiceProtocol.self) private var cacheService: CacheServiceProtocol
    @Injected(NetworkServiceProtocol.self) private var networkService: NetworkServiceProtocol
    
    init() {
    }
    
    func loadImage(from url: String) async throws -> UIImage {
        if let cachedImage = await cacheService.getCachedImage(for: url) {
            logInfo("Image loaded from cache: \(url)")
            return cachedImage
        }
        
        guard let imageURL = URL(string: url) else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: imageURL)
            
            guard data.count < ImageConstants.maxImageSizeBytes else {
                throw NetworkError.imageTooLarge
            }
            
            guard let image = UIImage(data: data) else {
                throw NetworkError.invalidImageData
            }
            
            let finalImage: UIImage
            if image.size.width > ImageConstants.maxImageDimension || image.size.height > ImageConstants.maxImageDimension {
                finalImage = image.resized(to: CGSize(width: ImageConstants.maxImageDimension, height: ImageConstants.maxImageDimension))
                logInfo("Image resized from \(image.size) to \(finalImage.size)")
            } else {
                finalImage = image
            }
            
            try await cacheService.cacheImage(finalImage, for: url)
            logInfo("Image loaded from network and cached: \(url)")
            
            return finalImage
        } catch {
            logError("Failed to load image from network: \(error.localizedDescription)")
            
            if let cachedImage = await cacheService.getCachedImage(for: url) {
                logInfo("Network failed, using cached image: \(url)")
                return cachedImage
            }
            
            throw error
        }
    }
    
}

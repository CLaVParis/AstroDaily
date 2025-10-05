//
//  CacheService.swift
//  AstroDaily
//
//  Created by Hu AN on 01/10/2025.
//

import Foundation
import UIKit

// MARK: - Cache Constants
private struct CacheConstants {
    static let maxAPODCacheSizeBytes = 10 * 1024 * 1024 // 10MB
    static let maxImageCacheSizeBytes = 20 * 1024 * 1024 // 20MB
}

// MARK: - Cache Service Implementation
class CacheService: CacheServiceProtocol {
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    
    private enum CacheKeys {
        static let lastAPOD = "last_apod"
        static let imagePrefix = "image_"
    }
    
    init() {
        // Try to create cache directory in Documents first
        let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let primaryCacheDirectory = documentsPath.appendingPathComponent("AstroDailyCache")
        
        do {
            if !fileManager.fileExists(atPath: primaryCacheDirectory.path) {
                try fileManager.createDirectory(at: primaryCacheDirectory, withIntermediateDirectories: true)
                logInfo("Cache directory created successfully")
            }
            cacheDirectory = primaryCacheDirectory
        } catch {
            // Fallback to temporary directory if Documents fails
            logError("Failed to create cache directory: \(error.localizedDescription)")
            let fallbackCacheDirectory = fileManager.temporaryDirectory.appendingPathComponent("AstroDailyCache")
            do {
                try fileManager.createDirectory(at: fallbackCacheDirectory, withIntermediateDirectories: true)
                logInfo("Using temporary directory for cache")
                cacheDirectory = fallbackCacheDirectory
            } catch {
                logError("Failed to create temporary cache directory: \(error.localizedDescription)")
                cacheDirectory = fileManager.temporaryDirectory
            }
        }
    }
    
    func cacheAPOD(_ apod: APOD) async throws {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(DateFormatter.apodDateFormatter)
        
        let data = try encoder.encode(apod)
        let fileURL = cacheDirectory.appendingPathComponent("\(CacheKeys.lastAPOD).json")
        
        do {
            try data.write(to: fileURL)
            logInfo("APOD cached successfully: \(apod.title)")
        } catch {
            logError("Failed to write APOD cache: \(error.localizedDescription)")
            throw CacheError.fileSystemError(error)
        }
    }
    
    func getCachedAPOD() async -> APOD? {
        let fileURL = cacheDirectory.appendingPathComponent("\(CacheKeys.lastAPOD).json")
        
        guard fileManager.fileExists(atPath: fileURL.path) else {
            logDebug("No cached APOD found")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            
            guard data.count < CacheConstants.maxAPODCacheSizeBytes else {
                logError("Cached APOD file too large: \(data.count) bytes")
                return nil
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.apodDateFormatter)
            
            let apod = try decoder.decode(APOD.self, from: data)
            logInfo("Cached APOD loaded: \(apod.title)")
            return apod
        } catch {
            logError("Failed to load cached APOD: \(error.localizedDescription)")
            return nil
        }
    }
    
    func cacheImage(_ image: UIImage, for url: String) async throws {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw CacheError.imageEncodingFailed
        }
        
        guard imageData.count < CacheConstants.maxImageCacheSizeBytes else {
            throw CacheError.imageEncodingFailed
        }
        
        let fileName = "\(CacheKeys.imagePrefix)\(url.hash).jpg"
        let fileURL = cacheDirectory.appendingPathComponent(fileName)
        
        do {
            try imageData.write(to: fileURL)
            logInfo("Image cached successfully for URL: \(url)")
        } catch {
            logError("Failed to write image cache: \(error.localizedDescription)")
            throw CacheError.fileSystemError(error)
        }
    }
    
    func getCachedImage(for url: String) async -> UIImage? {
        let fileName = "\(CacheKeys.imagePrefix)\(url.hash).jpg"
        let fileURL = cacheDirectory.appendingPathComponent(fileName)
        
        guard fileManager.fileExists(atPath: fileURL.path) else {
            logDebug("No cached image found for URL: \(url)")
            return nil
        }
        
        do {
            let imageData = try Data(contentsOf: fileURL)
            
            guard imageData.count < CacheConstants.maxImageCacheSizeBytes else {
                logError("Cached image file too large: \(imageData.count) bytes")
                return nil
            }
            
            guard let image = UIImage(data: imageData) else {
                logError("Failed to create UIImage from cached data")
                return nil
            }
            
            logInfo("Cached image loaded for URL: \(url)")
            return image
        } catch {
            logError("Failed to load cached image: \(error.localizedDescription)")
            return nil
        }
    }
    
    func clearCache() async throws {
        do {
            let contents = try fileManager.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: nil)
            
            for fileURL in contents {
                do {
                    try fileManager.removeItem(at: fileURL)
                } catch {
                    logError("Failed to remove cache file \(fileURL.lastPathComponent): \(error.localizedDescription)")
                }
            }
            
            logInfo("Cache cleared successfully")
        } catch {
            logError("Failed to clear cache: \(error.localizedDescription)")
            throw CacheError.fileSystemError(error)
        }
    }
}

// MARK: - Cache Error
enum CacheError: Error, LocalizedError {
    case imageEncodingFailed
    case fileSystemError(Error)
    
    var errorDescription: String? {
        switch self {
        case .imageEncodingFailed:
            return "Image encoding failed"
        case .fileSystemError(let error):
            return "File system error: \(error.localizedDescription)"
        }
    }
}

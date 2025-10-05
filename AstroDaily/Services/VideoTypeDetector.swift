//
//  VideoTypeDetector.swift
//  AstroDaily
//
//  Created by Hu AN on 01/10/2025.
//

import Foundation

// MARK: - Video Type Detector
// Analyzes video URL types, supports direct video files and embedded videos
class VideoTypeDetector {
    
    static func detectVideoType(_ url: URL) -> VideoDetectionResult {
        // Check direct video file extensions first
        if isDirectVideoFile(url) {
            return VideoDetectionResult(type: .direct, confidence: .high, reason: "Direct video file extension")
        }
        
        // Look for embedded video patterns
        if let embeddedResult = analyzeEmbeddedVideoPattern(url) {
            return embeddedResult
        }
        
        // Check URL parameters for video indicators
        if let metadataResult = analyzeVideoMetadata(url) {
            return metadataResult
        }
        
        // Look for iframe embedding patterns
        if let iframeResult = analyzeIframePattern(url) {
            return iframeResult
        }
        
        return VideoDetectionResult(type: .unknown, confidence: .low, reason: "No clear video indicators found")
    }
    
    private static func isDirectVideoFile(_ url: URL) -> Bool {
        let videoExtensions = ["mp4", "mov", "avi", "mkv", "webm", "m4v", "3gp", "flv", "m3u8", "ts"]
        let pathExtension = url.pathExtension.lowercased()
        
        if let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
           let queryItems = components.queryItems {
            for item in queryItems {
                if item.name.lowercased() == "format" || item.name.lowercased() == "type" {
                    if let value = item.value?.lowercased(),
                       videoExtensions.contains(value) || value.contains("video") {
                        return true
                    }
                }
            }
        }
        
        return videoExtensions.contains(pathExtension)
    }
    
    private static func analyzeEmbeddedVideoPattern(_ url: URL) -> VideoDetectionResult? {
        guard let host = url.host?.lowercased() else { return nil }
        let path = url.path.lowercased()
        
        let videoIndicators = ["video", "watch", "embed", "player", "stream"]
        let hostHasVideoIndicator = videoIndicators.contains { host.contains($0) }
        let pathHasVideoIndicator = videoIndicators.contains { path.contains($0) }
        
        if hostHasVideoIndicator || pathHasVideoIndicator {
            return VideoDetectionResult(type: .embedded, confidence: .high, reason: "URL contains video indicators")
        }
        
        let domainPatterns = [
            "player.", "embed.", "video.", "watch.", "stream.",
            ".tv", ".video", ".stream"
        ]
        
        let hasVideoDomain = domainPatterns.contains { pattern in
            host.hasPrefix(pattern) || host.hasSuffix(pattern)
        }
        
        if hasVideoDomain {
            return VideoDetectionResult(type: .embedded, confidence: .medium, reason: "Domain pattern suggests video platform")
        }
        
        return nil
    }
    
    private static func analyzeVideoMetadata(_ url: URL) -> VideoDetectionResult? {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else { return nil }
        
        let videoParams = ["v", "video", "embed", "autoplay", "controls", "loop", "muted"]
        let videoParamCount = queryItems.filter { item in
            videoParams.contains(item.name.lowercased())
        }.count
        
        if videoParamCount >= 2 {
            return VideoDetectionResult(type: .embedded, confidence: .high, reason: "Multiple video parameters detected")
        } else if videoParamCount == 1 {
            return VideoDetectionResult(type: .embedded, confidence: .medium, reason: "Single video parameter detected")
        }
        
        for item in queryItems {
            if item.name.lowercased() == "v" || item.name.lowercased() == "video" {
                if let value = item.value, isValidVideoId(value) {
                    return VideoDetectionResult(type: .embedded, confidence: .high, reason: "Valid video ID pattern detected")
                }
            }
        }
        
        return nil
    }
    
    private static func analyzeIframePattern(_ url: URL) -> VideoDetectionResult? {
        guard let host = url.host?.lowercased() else { return nil }
        
        let iframeIndicators = [
            "embed", "player", "widget", "iframe",
            "api", "oembed"
        ]
        
        let hasIframeIndicator = iframeIndicators.contains { host.contains($0) }
        
        if hasIframeIndicator {
            return VideoDetectionResult(type: .embedded, confidence: .medium, reason: "URL suggests iframe embedding")
        }
        
        return nil
    }
    
    static func isValidVideoId(_ id: String) -> Bool {
        // Validate video ID format: 6-20 characters, supports letters, numbers, underscores, hyphens
        if id.count >= VideoIdConstants.minLength && id.count <= VideoIdConstants.maxLength && id.allSatisfy({ $0.isLetter || $0.isNumber || $0 == "_" || $0 == "-" }) {
            return true
        }
        
        return false
    }
    
}

// MARK: - Supporting Types
struct VideoDetectionResult {
    let type: VideoType
    let confidence: DetectionConfidence
    let reason: String
}

enum VideoType {
    case direct
    case embedded
    case unknown
}

enum DetectionConfidence {
    case high
    case medium
    case low
}


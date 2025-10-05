//
//  VideoTypeDetectorTests.swift
//  AstroDailyTests
//
//  Created by Hu AN on 05/10/2025.
//

import XCTest
import Foundation
@testable import AstroDaily

final class VideoTypeDetectorTests: XCTestCase {
    
    func testDirectVideoDetection() {
        // Test detection of direct video files
        let directVideoURL = URL(string: "https://example.com/video.mp4")!
        let result = VideoTypeDetector.detectVideoType(directVideoURL)
        
        if case .direct = result.type {
            XCTAssertTrue(true)
        } else {
            XCTFail("Expected direct video type")
        }
    }
    
    func testEmbeddedVideoDetection() {
        // Test detection of embedded video URLs
        let embeddedVideoURL = URL(string: "https://www.youtube.com/watch?v=test")!
        let result = VideoTypeDetector.detectVideoType(embeddedVideoURL)
        
        if case .embedded = result.type {
            XCTAssertTrue(true)
        } else {
            XCTFail("Expected embedded video type")
        }
    }
    
    func testUnknownVideoDetection() {
        // Test handling of unknown URLs
        let unknownURL = URL(string: "https://example.com/unknown")!
        let result = VideoTypeDetector.detectVideoType(unknownURL)
        
        if case .unknown = result.type {
            XCTAssertTrue(true)
        } else {
            XCTFail("Expected unknown video type")
        }
    }
    
    func testVideoTypeEnum() {
        
        let directType = VideoType.direct
        let embeddedType = VideoType.embedded
        let unknownType = VideoType.unknown
        
        XCTAssertNotNil(directType)
        XCTAssertNotNil(embeddedType)
        XCTAssertNotNil(unknownType)
    }
    
    func testDetectionConfidenceEnum() {
        
        let highConfidence = DetectionConfidence.high
        let mediumConfidence = DetectionConfidence.medium
        let lowConfidence = DetectionConfidence.low
        
        XCTAssertNotNil(highConfidence)
        XCTAssertNotNil(mediumConfidence)
        XCTAssertNotNil(lowConfidence)
    }
    
    func testVideoIdValidation() {
        // Test valid video IDs (6-20 characters with alphanumeric and special chars)
        XCTAssertTrue(VideoTypeDetector.isValidVideoId("dQw4w9WgXcQ")) // 11 chars with mixed case
        XCTAssertTrue(VideoTypeDetector.isValidVideoId("abc123def45")) // 11 chars alphanumeric
        XCTAssertTrue(VideoTypeDetector.isValidVideoId("abc-123_def")) // 11 chars with special chars
        XCTAssertTrue(VideoTypeDetector.isValidVideoId("abc123")) // 6 chars
        XCTAssertTrue(VideoTypeDetector.isValidVideoId("abcdefghijklmnopqrst")) // 20 chars
        XCTAssertTrue(VideoTypeDetector.isValidVideoId("vimeo123")) // 8 chars
        
        // Test invalid IDs
        XCTAssertFalse(VideoTypeDetector.isValidVideoId("abc")) // Too short
        XCTAssertFalse(VideoTypeDetector.isValidVideoId("abcdefghijklmnopqrstu")) // Too long
        XCTAssertFalse(VideoTypeDetector.isValidVideoId("abc@123")) // Invalid character
        XCTAssertFalse(VideoTypeDetector.isValidVideoId("")) // Empty
    }
}

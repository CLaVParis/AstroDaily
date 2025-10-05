//
//  UniversalVideoPlayer.swift
//  AstroDaily
//
//  Created by Hu AN on 01/10/2025.
//

import SwiftUI
import WebKit
import AVKit

// MARK: - Universal Video Player
struct UniversalVideoPlayer: View {
    let videoURL: URL
    let title: String
    
    var body: some View {
        ZStack {
            ColorTheme.videoBackground
            
            // Choose player type based on URL analysis
            if isEmbeddedVideoURL(videoURL) {
                EmbeddedVideoWebView(url: videoURL)
            } else {
                DirectVideoPlayerView(url: videoURL)
            }
        }
        .frame(height: UIConstants.videoPlayerHeight)
        .cornerRadius(UIConstants.cornerRadius)
    }
    
    private func isEmbeddedVideoURL(_ url: URL) -> Bool {
        let detectionResult = VideoTypeDetector.detectVideoType(url)
        return detectionResult.type == .embedded
    }
}

// MARK: - Embedded Video Web View
struct EmbeddedVideoWebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
        configuration.allowsAirPlayForMediaPlayback = true
        configuration.allowsPictureInPictureMediaPlayback = true
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.backgroundColor = UIColor(ColorTheme.videoBackground)
        webView.isOpaque = false
        webView.scrollView.isScrollEnabled = false
        
        guard url.scheme == "http" || url.scheme == "https" else {
            logError("Invalid video URL scheme: \(url)")
            return webView
        }
        
        let navigationDelegate = VideoWebNavigationDelegate()
        webView.navigationDelegate = navigationDelegate
        
        var request = URLRequest(url: url)
        request.timeoutInterval = NetworkConstants.timeoutInterval
        webView.load(request)
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
    
}

// MARK: - Direct Video Player View
struct DirectVideoPlayerView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        
        guard url.scheme == "http" || url.scheme == "https" else {
            logError("Invalid video URL scheme: \(url)")
            return controller
        }
        
        let player = AVPlayer(url: url)
        controller.player = player
        controller.showsPlaybackControls = true
        controller.videoGravity = .resizeAspectFill
        controller.allowsPictureInPicturePlayback = true
        
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemFailedToPlayToEndTime,
            object: player.currentItem,
            queue: .main
        ) { notification in
            if let error = notification.userInfo?[AVPlayerItemFailedToPlayToEndTimeErrorKey] as? Error {
                logError("Video playback failed: \(error.localizedDescription)")
            }
        }
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
    }
}

// MARK: - Video Web Navigation Delegate
class VideoWebNavigationDelegate: NSObject, WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        logError("Video WebView failed to load: \(error.localizedDescription)")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        logError("Video WebView navigation failed: \(error.localizedDescription)")
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        logDebug("Video WebView started loading")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        logDebug("Video WebView finished loading")
    }
}

#Preview {
    UniversalVideoPlayer(
        videoURL: URL(string: "https://example.com/video.mp4")!,
        title: "Sample Video"
    )
}

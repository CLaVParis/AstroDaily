//
//  CacheServiceProtocol.swift
//  AstroDaily
//
//  Created by Hu AN on 04/10/2025.
//

import Foundation
import UIKit

// MARK: - Cache Service Protocol
protocol CacheServiceProtocol {
    func cacheAPOD(_ apod: APOD) async throws
    func getCachedAPOD() async -> APOD?
    func cacheImage(_ image: UIImage, for url: String) async throws
    func getCachedImage(for url: String) async -> UIImage?
    func clearCache() async throws
}


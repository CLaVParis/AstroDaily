//
//  ImageServiceProtocol.swift
//  AstroDaily
//
//  Created by Hu AN on 05/10/2025.
//
import Foundation
import UIKit

// MARK: - Image Service Protocol
protocol ImageServiceProtocol {
    func loadImage(from url: String) async throws -> UIImage
}


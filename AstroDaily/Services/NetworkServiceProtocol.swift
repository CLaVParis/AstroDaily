//
//  NetworkServiceProtocol.swift
//  AstroDaily
//
//  Created by Hu AN on 04/10/2025.
//

import Foundation

// MARK: - Network Service Protocol (Dependency Inversion Principle)
protocol NetworkServiceProtocol {
    func request<T: Codable>(url: String, responseType: T.Type) async throws -> T
}




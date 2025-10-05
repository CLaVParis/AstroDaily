//
//  APODServiceProtocol.swift
//  AstroDaily
//
//  Created by Hu AN on 01/10/2025.
//

import Foundation

// MARK: - APOD Service Protocol (Interface Segregation Principle)
protocol APODServiceProtocol {
    func fetchTodaysAPOD() async throws -> APODResult
    func fetchAPOD(for date: Date) async throws -> APODResult
}




//
//  APODResult.swift
//  AstroDaily
//
//  Created by Hu AN on 01/10/2025.
//

import Foundation

// MARK: - APOD Result
struct APODResult {
    let apod: APOD
    let isFromCache: Bool
    let isFallbackDate: Bool
    
    init(apod: APOD, isFromCache: Bool = false, isFallbackDate: Bool = false) {
        self.apod = apod
        self.isFromCache = isFromCache
        self.isFallbackDate = isFallbackDate
    }
}

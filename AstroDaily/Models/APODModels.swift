//
//  APODModels.swift
//  AstroDaily
//
//  Created by Hu AN on 01/10/2025.
//

import Foundation

// MARK: - APOD Response Model
struct APODResponse: Codable {
    let date: String
    let title: String
    let explanation: String
    let url: String
    let mediaType: String
    let hdurl: String?
    let copyright: String?
    
    enum CodingKeys: String, CodingKey {
        case date, title, explanation, url, copyright
        case mediaType = "media_type"
        case hdurl
    }
}

// MARK: - APOD Content Type
enum APODMediaType: String, CaseIterable, Codable {
    case image = "image"
    case video = "video"
    
    var displayName: String {
        switch self {
        case .image:
            return "Image"
        case .video:
            return "Video"
        }
    }
}

// MARK: - APOD Model (Domain Model)
struct APOD: Codable {
    let id: String
    let date: Date
    let title: String
    let explanation: String
    let mediaType: APODMediaType
    let url: URL
    let hdurl: URL?
    let copyright: String?
    
    enum CodingKeys: String, CodingKey {
        case id, date, title, explanation, url, hdurl, copyright
        case mediaType = "media_type"
    }
    
    init(from response: APODResponse) throws {
        self.id = response.date
        
        // Parse date string to Date object
        guard let parsedDate = DateFormatter.apodDateFormatter.date(from: response.date) else {
            throw NetworkError.invalidDate(Date())
        }
        self.date = parsedDate
        
        self.title = response.title
        self.explanation = response.explanation
        self.mediaType = APODMediaType(rawValue: response.mediaType) ?? .image
        
        // Validate and create main URL
        guard let url = URL(string: response.url),
              url.scheme != nil,
              url.host != nil else {
            throw NetworkError.invalidURL
        }
        self.url = url
        
        // Validate and create HD URL if available
        self.hdurl = response.hdurl.flatMap { hdurlString in
            guard let hdurl = URL(string: hdurlString),
                  hdurl.scheme != nil,
                  hdurl.host != nil else {
                return nil
            }
            return hdurl
        }
        
        self.copyright = response.copyright
    }
    
    init(id: String, date: Date, title: String, explanation: String, mediaType: APODMediaType, url: URL, hdurl: URL?, copyright: String?) {
        self.id = id
        self.date = date
        self.title = title
        self.explanation = explanation
        self.mediaType = mediaType
        self.url = url
        self.hdurl = hdurl
        self.copyright = copyright
    }
}

// MARK: - Date Formatter Extension
extension DateFormatter {
    static let apodDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static let displayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
}




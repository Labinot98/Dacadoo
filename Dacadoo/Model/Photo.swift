//
//  Photo.swift
//  Dacadoo
//
//  Created by Pajaziti Labinot on 14.5.24..
//

import Foundation

struct Photo: Codable {
    let urls: PhotoURLs
    let altDescription: String?
}

struct PhotoURLs: Codable {
    let regular: String
    let full: String
    
}

struct SearchResult: Codable {
    let results: [Photo]
}

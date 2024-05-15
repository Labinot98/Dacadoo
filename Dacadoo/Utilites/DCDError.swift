//
//  DCDError.swift
//  Dacadoo
//
//  Created by Pajaziti Labinot on 14.5.24..
//

enum PhotoLoadingError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case invalidData
    case decodingError(Error)
}

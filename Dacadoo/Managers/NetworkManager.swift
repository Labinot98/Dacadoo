//
//  NetworkManager.swift
//  Dacadoo
//
//  Created by Pajaziti Labinot on 14.5.24..
//

import UIKit

protocol PhotoDataProvider {
    func searchPhotos(for username: String, completion: @escaping (Result<[Photo], PhotoLoadingError>) -> Void)
}

class NetworkManager: PhotoDataProvider {
    static let shared = NetworkManager()
    private let baseURL = "https://api.unsplash.com/search/photos"
    private let apiKey = "NHr5nmnvy4fJA0AtfpReQm_EI2SBnnvPajDObRtmYbY"
    let cache = NSCache<NSString, UIImage>()
    var session: URLSession = URLSession.shared

    private init() {}


        func searchPhotos(for query: String, completion: @escaping (Result<[Photo], PhotoLoadingError>) -> Void) {
            let queryItems = [
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "client_id", value: apiKey)
            ]

            var components = URLComponents(string: baseURL)
            components?.queryItems = queryItems

            guard let url = components?.url else {
                completion(.failure(.invalidURL))
                return
            }

            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(.networkError(error)))
                    return
                }

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(.failure(.invalidResponse))
                    return
                }

                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let searchResult = try decoder.decode(SearchResult.self, from: data)
                    completion(.success(searchResult.results))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }

            task.resume()
        }

        func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
            let cacheKey = NSString(string: urlString)

            if let image = cache.object(forKey: cacheKey) {
                completed(image)
                return
            }

            guard let url = URL(string: urlString) else {
                completed(nil)
                return
            }

            let task = session.dataTask(with: url) { [weak self] data, _, _ in
                guard let self = self,
                      let data = data,
                      let image = UIImage(data: data) else {
                    completed(nil)
                    return
                }

                let resizedImage = self.resizeImage(image: image, targetWidth: 300)
                self.cache.setObject(resizedImage, forKey: cacheKey)
                completed(resizedImage)
            }

            task.resume()
        }

        private func resizeImage(image: UIImage, targetWidth: CGFloat) -> UIImage {
            let size = image.size
            let widthRatio = targetWidth / size.width
            let newSize = CGSize(width: targetWidth, height: size.height * widthRatio)

            UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
            image.draw(in: CGRect(origin: .zero, size: newSize))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return newImage ?? image
        }
    }

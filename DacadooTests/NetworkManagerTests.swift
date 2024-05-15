//
//  NetworkManagerTests.swift
//  DacadooTests
//
//  Created by Pajaziti Labinot on 15.5.24..
//

import XCTest
@testable import Dacadoo

class NetworkManagerTests: XCTestCase {

    var networkManager: NetworkManager!

    override func setUp() {
        super.setUp()
        networkManager = NetworkManager.shared
    }

    override func tearDown() {
        networkManager = nil
        super.tearDown()
    }

    func testSearchPhotosSuccess() {
        let mockSession = MockURLSession()
        networkManager.session = mockSession
        let expectedPhotos = [Photo(urls: PhotoURLs(regular: "https://example.com/regular1.jpg", full: "https://example.com/full1.jpg"), altDescription: "Description1"),
                              Photo(urls: PhotoURLs(regular: "https://example.com/regular2.jpg", full: "https://example.com/full2.jpg"), altDescription: "Description2")]
        let searchResult = SearchResult(results: expectedPhotos)
        mockSession.data = try? JSONEncoder().encode(searchResult)
        mockSession.response = HTTPURLResponse(url: URL(string: "https://api.unsplash.com/search/photos")!, statusCode: 200, httpVersion: nil, headerFields: nil)

        let expectation = self.expectation(description: "SearchPhotosCompletion")

        networkManager.searchPhotos(for: "test") { result in
            switch result {
            case .success(let photos):
                XCTAssertEqual(photos, expectedPhotos)
            case .failure:
                XCTFail("Expected success, got failure")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testSearchPhotosFailure() {
       
        let mockSession = MockURLSession()
        networkManager.session = mockSession
        mockSession.error = NSError(domain: "NetworkError", code: 1, userInfo: nil)

        let expectation = self.expectation(description: "SearchPhotosCompletion")

        networkManager.searchPhotos(for: "test") { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                // Then
                if case .networkError(let networkError) = error {
                    XCTAssertEqual(networkError.localizedDescription, mockSession.error?.localizedDescription)
                } else {
                    XCTFail("Expected network error")
                }
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testDownloadImageFailure() {
        let urlString = "https://example.com/image.jpg"
        let mockSession = MockURLSession()
        networkManager.session = mockSession
        mockSession.error = NSError(domain: "NetworkError", code: 1, userInfo: nil)

        let expectation = self.expectation(description: "DownloadImageCompletion")
        networkManager.downloadImage(from: urlString) { downloadedImage in
            XCTAssertNil(downloadedImage)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}

class MockURLSession: URLSession {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
   
    
    init(data: Data? = nil, response: URLResponse? = nil, error: Error? = nil) {
        self.data = data
        self.response = response
        self.error = error
        super.init()
    }
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return MockURLSessionDataTask {
            completionHandler(self.data, self.response, self.error)
        }
    }
}


class MockURLSessionDataTask: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
        super.init()
    }

    override func resume() {
        closure()
    }
}


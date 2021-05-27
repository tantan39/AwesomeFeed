//
//  RemoteFeedLoaderTests.swift
//  AwesomeFeedTests
//
//  Created by Tan Tan on 5/27/21.
//

import XCTest
import AwesomeFeed

class RemoteFeedLoaderTests: XCTestCase {
    func test_init_withoutRequest() {
        let client = HTTPClientSpy()
        let _ = makeSUT()
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        
        let sut = makeSUT()
        sut.sut.load()
        
        XCTAssertNotNil(sut.spy.requestedURL)
    }
    
    // MARK: - Helpers
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!) -> (sut: RemoteFeedLoader, spy: HTTPClientSpy) {
        let client = HTTPClientSpy()
        return (RemoteFeedLoader(url: url, client: client), client)
    }
    
    
    class HTTPClientSpy: HTTPClient {
        var requestedURL: URL?
        
        func get(url: URL) {
            requestedURL = url
        }
    }
}

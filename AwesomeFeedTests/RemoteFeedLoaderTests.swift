//
//  RemoteFeedLoaderTests.swift
//  AwesomeFeedTests
//
//  Created by Tan Tan on 5/27/21.
//

import XCTest

class RemoteFeedLoader {
    var requestedURL: URL?
    let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func load() {
        HTTPClient.shared.requestedURL = URL(string: "https://a-url.com")
    }
}

class HTTPClient {
    static let shared = HTTPClient()
    
    private init () {}
    
    var requestedURL: URL?
}

class RemoteFeedLoaderTests: XCTestCase {

    func test_init_withoutRequest() {
        let client = HTTPClient.shared
        let _ = RemoteFeedLoader(client: client)
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        let client = HTTPClient.shared
        let remoteLoader = RemoteFeedLoader(client: client)
        remoteLoader.load()
        
        XCTAssertNotNil(client.requestedURL)
    }
}

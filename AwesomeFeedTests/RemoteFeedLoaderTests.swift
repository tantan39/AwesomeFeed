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
        HTTPClient.shared.get(url: URL(string: "https://a-url.com")!)
    }
}

class HTTPClient {
    static var shared = HTTPClient()
        
    var requestedURL: URL?
    
    func get(url: URL) { }
}

class HTTPClientSpy: HTTPClient {
    
    override func get(url: URL) {
        requestedURL = url
    }
}

class RemoteFeedLoaderTests: XCTestCase {

    func test_init_withoutRequest() {
        let client = HTTPClient.shared
        let _ = RemoteFeedLoader(client: client)
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        let client = HTTPClientSpy()
        HTTPClient.shared = client
        
        let remoteLoader = RemoteFeedLoader(client: client)
        remoteLoader.load()
        
        XCTAssertNotNil(client.requestedURL)
    }
}

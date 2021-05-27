//
//  RemoteFeedLoaderTests.swift
//  AwesomeFeedTests
//
//  Created by Tan Tan on 5/27/21.
//

import XCTest

class RemoteFeedLoader {
    let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func load() {
        client.get(url: URL(string: "https://a-url.com")!)
    }
}

protocol HTTPClient {
    func get(url: URL)
}

class HTTPClientSpy: HTTPClient {
    var requestedURL: URL?
    
    func get(url: URL) {
        requestedURL = url
    }

}

class RemoteFeedLoaderTests: XCTestCase {

    func test_init_withoutRequest() {
        let client = HTTPClientSpy()
        let _ = RemoteFeedLoader(client: client)
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        let client = HTTPClientSpy()
        
        let remoteLoader = RemoteFeedLoader(client: client)
        remoteLoader.load()
        
        XCTAssertNotNil(client.requestedURL)
    }
}

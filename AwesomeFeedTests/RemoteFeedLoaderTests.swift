//
//  RemoteFeedLoaderTests.swift
//  AwesomeFeedTests
//
//  Created by Tan Tan on 5/27/21.
//

import XCTest

class RemoteFeedLoader {
    var urlRequest: URL?
    let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func load() {
        
    }
}

class HTTPClient {
    static let instance = HTTPClient()
    
    private init () {}
    
    var urlRequest: URL?
    
}

class RemoteFeedLoaderTests: XCTestCase {

    func test_init_withoutRequest() {
        let client = HTTPClient.instance
        let _ = RemoteFeedLoader(client: client)
        
        XCTAssertNil(client.urlRequest)
    }
}

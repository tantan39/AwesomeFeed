//
//  FeedEndpointTests.swift
//  AwesomeFeedTests
//
//  Created by Tan Tan on 8/16/21.
//

import XCTest
import AwesomeFeed

class FeedEndpointTests: XCTestCase {
    func test_feed_endpointURL() {
        let baseURL = URL(string: "http://base-url.com")!
        
        let received = FeedEndpoint.get.url(baseURL: baseURL)
        let expected = URL(string: "http://base-url.com/v1/feed")!
        
        XCTAssertEqual(received, expected)
    }
}

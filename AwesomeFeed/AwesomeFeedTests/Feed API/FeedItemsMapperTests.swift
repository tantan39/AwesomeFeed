//
//  RemoteFeedLoaderTests.swift
//  AwesomeFeedTests
//
//  Created by Tan Tan on 5/27/21.
//

import XCTest
import AwesomeFeed

class FeedItemsMapperTests: XCTestCase {
    func test_map_throwsErrorOnNon200HTTPResponse() throws {
        let json = makeJSONItems([])
        let sample = [199, 201, 300, 400, 500]
        
        try sample.forEach { code in
            XCTAssertThrowsError(
                try FeedItemsMapper.map(json, response: HTTPURLResponse(statusCode: code))
            )
        }
        
    }
    
    func test_map_throwsErrorOnNon200HTTPResponseWithInvalidJSON() {
        let invalidJSON = "invalid json data".data(using: .utf8)!
        
        XCTAssertThrowsError(
            try FeedItemsMapper.map(invalidJSON, response: HTTPURLResponse(statusCode: 200))
        )
    }
    
    func test_map_deliversNoItemWith200HTTPResponseWithEmptyJSONList() throws {
        let emptyJSONList = makeJSONItems([])
        
        let result = try FeedItemsMapper.map(emptyJSONList, response: HTTPURLResponse(statusCode: 200))
        
        XCTAssertEqual(result, [])
    }
    
    func test_map_deliversListItemOn200HTTPResponseWithJSONList() throws {
                
        let item1 = makeItem(id: UUID(), description: nil, location: nil, url: URL(string: "https://a-url.com")!)
        
        let item2 = makeItem(id: UUID(), description: "a description", location: "a location", url: URL(string: "https://a-url.com")!)
        
        let json = makeJSONItems([item1.json, item2.json])
        
        let result = try FeedItemsMapper.map(json, response: HTTPURLResponse(statusCode: 200))
        
        XCTAssertEqual(result, [item1.model, item2.model])
    }
    
    // MARK: - Helpers
    private func failure(_ error: RemoteFeedLoader.Error) -> RemoteFeedLoader.Result {
        return .failure(error)
    }
    
    private func makeItem(id: UUID, description: String? = nil, location: String? = nil, url: URL) -> (model: FeedImage, json: [String: Any])  {
        let item = FeedImage(id: id, description: description, location: location, url: url)
        let json = [ "id": item.id.description,
                          "description": item.description,
                          "location": item.location,
                          "image": item.url.absoluteString
        ]
        .compactMapValues({ $0 })

        return (item, json)
    }

}

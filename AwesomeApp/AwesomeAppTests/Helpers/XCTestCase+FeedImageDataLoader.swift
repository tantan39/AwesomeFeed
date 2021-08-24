//
//  XCTestCase+FeedImageDataLoader.swift
//  AwesomeAppTests
//
//  Created by Tan Tan on 7/12/21.
//

import XCTest
import AwesomeFeed

protocol FeedImageDataLoaderTestCase: XCTestCase { }

extension FeedImageDataLoaderTestCase {
    func expect(_ sut: FeedImageDataLoader, toCompleteWith expectedResult: Result<Data, Error>, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        
        action()
        let receivedResult = Result { try sut.loadImageData(from: anyURL()) }
            switch (receivedResult, expectedResult) {
            case let (.success(receivedFeed), .success(expectedFeed)):
                XCTAssertEqual(receivedFeed, expectedFeed, file: file, line: line)
                
            case (.failure, .failure):
                break
                
            default:
                XCTFail("Expected \(expectedResult), got \(receivedResult) instead", file: file, line: line)
        }
    }
}

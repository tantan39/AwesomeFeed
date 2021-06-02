//
//  LoadFeedFromCacheUseCaseTests.swift
//  AwesomeFeedTests
//
//  Created by Tan Tan on 6/2/21.
//

import XCTest
import AwesomeFeed

class LoadFeedFromCacheUseCaseTests: XCTestCase {
    func test_init_doesNotMessageStoreUponCreation() {
        let (_, store) = makeSUT()
        
        XCTAssertEqual(store.receiveMessages, [])
    }
    
    func test_load_requestsCacheRetrieval() {
        let (sut, store) = makeSUT()
        
        sut.load(completion: { _ in})
        
        XCTAssertEqual(store.receiveMessages, [.retrieve])
    }
    
    func test_load_failOnRetrievalError() {
        let (sut, store) = makeSUT()
        var receiveError: Error?
        let retrievalError = anyError()
        let exp = expectation(description: "Waiting for load completion")
         
        sut.load(completion: { error in
            receiveError = error
            exp.fulfill()
        })
        
        store.completeRetrieval(with: retrievalError)
        wait(for: [exp], timeout: 1.0)
        
        XCTAssertEqual(receiveError as NSError?, retrievalError)
    }
    
    // MARK: - Helpers
    private func makeSUT(currentDate: @escaping () -> Date = Date.init ,file: StaticString = #filePath, line: UInt = #line) -> (sut: LocalFeedLoader, store: FeedStoreSpy) {
        let store = FeedStoreSpy()
        let sut = LocalFeedLoader(store: store, currentDate: currentDate)
        trackMemoryLeaks(store, file: file, line: line)
        trackMemoryLeaks(sut, file: file, line: line)
        return (sut, store)
    }
    
    private func anyError() -> NSError {
        return NSError(domain: "any error", code: 0)
    }
}

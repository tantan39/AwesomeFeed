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
        let retrievalError = anyError()
        
        expect(sut, toCompleteWith: .failure(retrievalError)) {
            store.completeRetrieval(with: retrievalError)
        }
    }
    
    func test_load_deliversNoImagesOnEmptyCache() {
        let (sut, store) = makeSUT()
        let receiveImages: [FeedImage] = []
        expect(sut, toCompleteWith: .success(receiveImages)) {
            store.completeRetrievalWithEmptyCache()
        }
    }
    
    // MARK: - Helpers
    private func makeSUT(currentDate: @escaping () -> Date = Date.init ,file: StaticString = #filePath, line: UInt = #line) -> (sut: LocalFeedLoader, store: FeedStoreSpy) {
        let store = FeedStoreSpy()
        let sut = LocalFeedLoader(store: store, currentDate: currentDate)
        trackMemoryLeaks(store, file: file, line: line)
        trackMemoryLeaks(sut, file: file, line: line)
        return (sut, store)
    }
    
    private func expect(_ sut: LocalFeedLoader, toCompleteWith expectedResult: LocalFeedLoader.LoadResult, when action: @escaping () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "Waiting for load completion")

        sut.load(completion: { receiveResult in
            switch (receiveResult, expectedResult) {
            case let (.success(receiveResult), .success(expectedResult)):
                XCTAssertEqual(receiveResult, expectedResult, file: file, line: line)
                
            case let (.failure(receiveError), .failure(expectedError)):
                XCTAssertEqual(receiveError as NSError, expectedError as NSError, file: file, line: line)
            default:
                XCTFail("Expected failure, got \(receiveResult), got \(expectedResult) instead")
            }
            exp.fulfill()
        })
        action()
        wait(for: [exp], timeout: 1.0)

    }
    
    private func anyError() -> NSError {
        return NSError(domain: "any error", code: 0)
    }
}

//
//  CacheFeedUseCaseTests.swift
//  AwesomeFeedTests
//
//  Created by Tan Tan on 6/1/21.
//

import XCTest
import AwesomeFeed

class LocalFeedLoader {
    private var store: FeedStore
    
    init(store: FeedStore) {
        self.store = store
    }
    
    func save(_ items: [FeedItem]) {
        store.deleteCachedFeed()
    }
    
}

class FeedStore {
    var deleteCachedFeedCallCount: Int = 0
    
    func deleteCachedFeed() {
            deleteCachedFeedCallCount += 1
    }
    
}

class CacheFeedUseCaseTests: XCTestCase {

    func test_init_doesNotDeleteCacheUponCreation() {
        let store = FeedStore()
        _ = LocalFeedLoader(store: store)
        
        XCTAssertEqual(store.deleteCachedFeedCallCount, 0)
    }
    
    func test_save_requestsCacheDeletion() {
        let store = FeedStore()
        let sut = LocalFeedLoader(store: store)
        let items = [uniqueItem(), uniqueItem()]
            
        sut.save(items)
        XCTAssertEqual(store.deleteCachedFeedCallCount, 1)
    }
    
    // MARK: - Helpers
    private func uniqueItem() -> FeedItem {
        return FeedItem(id: UUID(), description: nil, location: nil, url: anyURL())
    }
    
    private func anyURL() -> URL {
        return URL(string: "http://any-url.com")!
    }

}

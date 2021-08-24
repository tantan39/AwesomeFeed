//
//  InMemoryFeedStore.swift
//  AwesomeAppTests
//
//  Created by Tan Tan on 7/26/21.
//

import AwesomeFeed

class InMemoryFeedStore {
    private(set) var feedCache: CachedFeed?
    private var feedImageDataCache: [URL: Data] = [:]
    
    init(feedCache: CachedFeed? = nil) {
        self.feedCache = feedCache
    }

    static var empty: InMemoryFeedStore {
        InMemoryFeedStore()
    }
    
    static var withExpiredFeedCache: InMemoryFeedStore {
        InMemoryFeedStore(feedCache: CachedFeed(feed: [], timestamp: Date.distantPast))
    }
    
    static var withNonExpiredFeedCache: InMemoryFeedStore {
        InMemoryFeedStore(feedCache: CachedFeed(feed: [], timestamp: Date()))
    }
}

extension InMemoryFeedStore: FeedStore {
    func deleteCachedFeed(completion: @escaping FeedStore.DeletionCompletion) {
        feedCache = nil
        completion(.success(()))
    }
    
    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping FeedStore.InsertionCompletion) {
        feedCache = CachedFeed(feed: feed, timestamp: timestamp)
        completion(.success(()))
    }
    
    func retrieve(completion: @escaping FeedStore.RetrievalCompletion) {
        completion(.success(feedCache))
    }
}

extension InMemoryFeedStore: FeedImageDataStore {
    func insert(_ data: Data, for url: URL) throws {
        feedImageDataCache[url] = data
    }
    
    func retrieve(dataForURL url: URL) throws -> Data? {
        return feedImageDataCache[url]
    }
}

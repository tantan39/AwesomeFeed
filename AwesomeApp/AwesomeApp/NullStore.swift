//
//  NullStore.swift
//  AwesomeApp
//
//  Created by Tan Tan on 8/21/21.
//

import AwesomeFeed

class NullStore: FeedStore & FeedImageDataStore {
    func deleteCachedFeed() throws {}
    
    func insert(_ feed: [LocalFeedImage], timestamp: Date) throws {}
    
    func retrieve() throws -> CachedFeed? { return .none }
    
    func insert(_ data: Data, for url: URL) throws {}
    
    func retrieve(dataForURL url: URL) -> Data? { return .none }
}



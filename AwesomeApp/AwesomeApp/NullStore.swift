//
//  NullStore.swift
//  AwesomeApp
//
//  Created by Tan Tan on 8/21/21.
//

import AwesomeFeed

class NullStore: FeedStore & FeedImageDataStore {
    func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        completion(.success(()))
    }
    
    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        completion(.success(()))
    }
    
    func retrieve(completion: @escaping RetrievalCompletion) {
        completion(.success(.none))
    }
    
    func insert(_ data: Data, for url: URL) throws {}
    
    func retrieve(dataForURL url: URL) -> Data? { return .none }
}



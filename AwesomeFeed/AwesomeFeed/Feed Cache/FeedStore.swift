//
//  FeedStore.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 6/1/21.
//

import Foundation

public typealias CachedFeed = (feed: [LocalFeedImage], timestamp: Date)

public protocol FeedStore {
    
    func deleteCachedFeed() throws
    func insert(_ feed: [LocalFeedImage], timestamp: Date) throws
    func retrieve() throws -> CachedFeed?
    
//    typealias DeletionResult = Result<Void, Error>
//    typealias DeletionCompletion = (DeletionResult) -> Void
//
//    typealias InsertionResult = Result<Void, Error>
//    typealias InsertionCompletion = (InsertionResult) -> Void
//
//    typealias RetrievalResult = Result<CachedFeed?, Error>
//    typealias RetrievalCompletion = (RetrievalResult) -> Void
    
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
//    @available(*, deprecated)
//    func deleteCachedFeed(completion: @escaping DeletionCompletion)
    
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
//    @available(*, deprecated)
//    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion)
    
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
//    @available(*, deprecated)
//    func retrieve(completion: @escaping RetrievalCompletion)
}

//public extension FeedStore {
//    func deleteCachedFeed() throws {
//        let dispatchGroup = DispatchGroup()
//        dispatchGroup.enter()
//        var result: DeletionResult!
//        
//        deleteCachedFeed(completion: {
//            result = $0
//            dispatchGroup.leave()
//        })
//        dispatchGroup.wait()
//        
//        return try result.get()
//    }
//    
//    func insert(_ feed: [LocalFeedImage], timestamp: Date) throws {
//        let dispatchGroup = DispatchGroup()
//        dispatchGroup.enter()
//        var result: InsertionResult!
//        
//        insert(feed, timestamp: timestamp, completion: {
//            result = $0
//            dispatchGroup.leave()
//        })
//        dispatchGroup.wait()
//        
//        return try result.get()
//    }
//    
//    func retrieve() throws -> CachedFeed? {
//        let dispatchGroup = DispatchGroup()
//        dispatchGroup.enter()
//        var result: RetrievalResult!
//        
//        retrieve(completion: {
//            result = $0
//            dispatchGroup.leave()
//        })
//        dispatchGroup.wait()
//        
//        return try result.get()
//    }
//    
//    func deleteCachedFeed(completion: @escaping DeletionCompletion) {}
//    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {}
//    func retrieve(completion: @escaping RetrievalCompletion) {}
//}

//
//  CoreDataFeedStore+FeedStore.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 7/8/21.
//

import Foundation

extension CoreDataFeedStore: FeedStore {
    public func retrieve() throws -> CachedFeed? {
        try performSync { context in
            Result {
                try ManagedCache.find(in: context).map {
                    CachedFeed(feed: $0.localFeed, timestamp: $0.timestamp)
                }
            }
        }
    }
    
    public func insert(_ feed: [LocalFeedImage], timestamp: Date) throws {
        try performSync { context in
            Result {
                let manageCache = try ManagedCache.newUniqueInstance(in: context)
                manageCache.timestamp = timestamp

                manageCache.feed = ManagedFeedImage.images(from: feed, in: context)
                
                try context.save()
            }
        }
    }
    
    public func deleteCachedFeed() throws {
        try performSync { context in
            Result {
                try ManagedCache.deleteCache(in: context)
            }
        }
    }

}

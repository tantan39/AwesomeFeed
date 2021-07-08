//
//  CoreDataFeedStore+FeedStore.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 7/8/21.
//

import Foundation

extension CoreDataFeedStore: FeedStore {
    public func retrieve(completion: @escaping RetrievalCompletion) {
        perform { context in
            completion( Result(catching: {
                try ManagedCache.find(in: context).map {
                    CachedFeed(feed: $0.localFeed, timestamp: $0.timestamp)
                }
            }))
        }
    }
    
    public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        perform { context in
            completion( Result(catching: {
                let manageCache = try ManagedCache.newUniqueInstance(in: context)
                manageCache.timestamp = timestamp

                manageCache.feed = ManagedFeedImage.images(from: feed, in: context)
                
                try context.save()
            }))
           
        }
        
    }
    
    public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        
        perform { context in
            completion( Result(catching: {
                try ManagedCache.find(in: context).map(context.delete).map(context.save)
            }))
        }
        
    }
}

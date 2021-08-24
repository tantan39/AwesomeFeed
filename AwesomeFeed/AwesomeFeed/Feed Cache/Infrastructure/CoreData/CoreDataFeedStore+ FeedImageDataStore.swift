//
//  CoreDataFeedStore+FeedImageDataLoader.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 7/8/21.
//

import Foundation

extension CoreDataFeedStore: FeedImageDataStore {
    public func insert(_ data: Data, for url: URL, completion: @escaping (FeedImageDataStore.InsertionResult) -> Void) {
        perform { context in
            completion( Result {
//                let image = try? ManagedFeedImage.first(with: url, in: context)
//                image?.data = data
//                try? context.save()
                try ManagedFeedImage.first(with: url, in: context)
                    .map { $0.data = data }
                    .map (context.save)
            })
        }
    }
    
    public func retrieve(dataForURL url: URL, completion: @escaping (FeedImageDataStore.RetrievalResult) -> Void) {
        
        perform { context in
            completion(Result {
                try ManagedFeedImage.data(with: url, in: context)
            })
        }
    }
    
}
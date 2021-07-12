//
//  FeedLoaderCacheDecorator.swift
//  AwesomeApp
//
//  Created by Tan Tan on 7/12/21.
//

import AwesomeFeed

public final class FeedLoaderCacheDecorator: FeedLoader {
    private let decoratee: FeedLoader
    private let cache: FeedCache
    
    public init(decoratee: FeedLoader, cache: FeedCache) {
        self.decoratee = decoratee
        self.cache = cache
    }
    
    public func load(completion: @escaping (FeedLoader.Result) -> Void) {
        decoratee.load(completion: { [weak self] result in

            completion(result.map { feed in
                self?.cache.save(feed, completion: { _ in })
                return feed
            })
        })
    }
}

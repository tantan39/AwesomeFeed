//
//  FeedImageDataLoaderCacheDecorator.swift
//  AwesomeApp
//
//  Created by Tan Tan on 7/12/21.
//

import AwesomeFeed

public final class FeedImageDataLoaderCacheDecorator: FeedImageDataLoader {
    private let decoratee: FeedImageDataLoader
    private let cache: FeedImageDataCache
    
    public init(decoratee: FeedImageDataLoader, cache: FeedImageDataCache) {
        self.decoratee = decoratee
        self.cache = cache
    }
    
    public func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        return self.decoratee.loadImageData(from: url, completion: { [weak self] result in
            completion(result.map { data in
                self?.cache.save(data, for: url, completion: { _ in })
                return data
            })
        })
    }
}

//
//  LocalFeedImageDataLoader.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 7/7/21.
//

import Foundation

public final class LocalFeedImageDataLoader {
    private final class Task: FeedImageDataLoaderTask {
        private var completion: ((FeedImageDataLoader.Result) -> Void)?
        
        init(_ completion: @escaping (FeedImageDataLoader.Result) -> Void) {
            self.completion = completion
        }
        
        func complete(with result: FeedImageDataLoader.Result) {
            completion?(result)
        }
        
        func cancel() {
            preventFurtherCompletions()
        }
        
        private func preventFurtherCompletions() {
            completion = nil
        }
        
    }
    
    private let store: FeedImageDataStore
    
    public init(store: FeedImageDataStore) {
        self.store = store
    }
    
}

extension LocalFeedImageDataLoader: FeedImageDataCache {
    public typealias SaveResult = FeedImageDataCache.Result

    public enum SaveError: Error {
        case failed
    }
    
    public func save(_ data: Data, for url: URL, completion: @escaping (SaveResult) -> Void) {
        completion( SaveResult {
            try store.insert(data, for: url)
        }.mapError { _ in SaveError.failed })
    }
}

extension LocalFeedImageDataLoader: FeedImageDataLoader {
    public typealias LoadResult = FeedImageDataLoader.Result

    public enum LoadError: Swift.Error {
        case failed
        case notFound
    }
    
    public func loadImageData(from url: URL, completion: @escaping (LoadResult) -> Void) -> FeedImageDataLoaderTask {
        let task = Task(completion)
        task.complete (with: Swift.Result {
            try store.retrieve(dataForURL: url)
        }
        .mapError { _ in LoadError.failed }
        .flatMap({ data in data.map { .success($0) } ?? .failure(LoadError.notFound) }))
        
        return task
    }
}

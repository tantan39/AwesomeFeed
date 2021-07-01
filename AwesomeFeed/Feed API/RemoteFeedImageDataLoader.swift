//
//  RemoteFeedImageDataLoader.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 6/30/21.
//

import Foundation

public final class RemoteFeedImageDataLoader: FeedImageDataLoader {
    private var client: HTTPClient
    
    public init(client: HTTPClient) {
        self.client = client
    }
    
    public enum Error: Swift.Error {
        case invalidData
        case connectivity
    }
    
    private final class HTTPClientTaskWrapper: FeedImageDataLoaderTask {
        private var completion: ((FeedImageDataLoader.Result) -> Void)?

        var wrapped: HTTPClientTask?
        
        init(_ completion: @escaping (FeedImageDataLoader.Result) -> Void) {
            self.completion = completion
        }
        
        func complete(with result: FeedImageDataLoader.Result) {
            completion?(result)
        }
        
        func cancel() {
            preventFurtherCompletions()
            wrapped?.cancel()
        }
        
        private func preventFurtherCompletions() {
            completion = nil
        }
    }
    
    public func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        let task = HTTPClientTaskWrapper(completion)
        task.wrapped = self.client.get(url: url, completion: { [weak self] result in
            guard self != nil else { return }
            task.complete(with: result
                            .mapError({ _ in Error.connectivity})
                            .flatMap({ (data, response) in
                                let isValidResponse = response.isOK && !data.isEmpty
                                return isValidResponse ? .success(data) : .failure(Error.invalidData)
                            })
            )
        })
        
        return task
    }
}

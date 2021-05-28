//
//  RemoteFeedLoader.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 5/27/21.
//

import Foundation

public final class RemoteFeedLoader {
    private let client: HTTPClient
    private let url: URL
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public enum Error: Swift.Error {
        case connectionError
        case invalidData
    }
    
    public enum Results: Equatable {
        case success([FeedItem])
        case failure(Error)
    }
    
    public func load(completion: @escaping (Results) -> Void) {
        client.get(url: url, completion: { [weak self] result in
            guard let _ = self else { return }
            
            switch result {
            case let .success(data, response):
                completion(FeedItemsMapper.map(data, response: response))
            case .failure:
                completion(.failure(.connectionError))
            }

        })
    }

}

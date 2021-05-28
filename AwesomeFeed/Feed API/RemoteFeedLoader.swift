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
        client.get(url: url, completion: { result in
            switch result {
            case let .success(data, response):
                completion(self.map(data, response: response))
            case .failure:
                completion(.failure(.connectionError))
            }

        })
    }
    
    private func map(_ data: Data, response: HTTPURLResponse) -> Results {
        if let items = try? FeedItemsMapper.map(data, response) {
            return .success(items)
        } else {
            return .failure(.invalidData)
        }
    }
}

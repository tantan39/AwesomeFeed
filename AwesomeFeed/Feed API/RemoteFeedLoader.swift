//
//  RemoteFeedLoader.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 5/27/21.
//

import Foundation

public protocol HTTPClient {
    func get(url: URL, completion: @escaping (Error) -> Void)
}

public final class RemoteFeedLoader {
    private let client: HTTPClient
    private let url: URL
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public enum Error: Swift.Error {
        case connectionError
    }
    
    public func load(completion: @escaping (Error) -> Void = { _ in }) {
        client.get(url: url, completion: { error in
            completion(.connectionError)
        })
    }
}



//
//  RemoteFeedLoader.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 5/27/21.
//

import Foundation
public enum HTTPClientResult {
    case success(HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(url: URL, completion: @escaping (HTTPClientResult) -> Void)
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
        case invalidData
    }
    
    public func load(completion: @escaping (Error) -> Void) {
        client.get(url: url, completion: { result in
            switch result {
            case .success:
                completion(.invalidData)
            case .failure:
                completion(.connectionError)
            }

        })
    }
}



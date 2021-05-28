//
//  RemoteFeedLoader.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 5/27/21.
//

import Foundation
p
public protocol HTTPClient {
    func get(url: URL, completion: @escaping (Error?, HTTPURLResponse?) -> Void)
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
        client.get(url: url, completion: { error, response in
            if let _ = error {
                completion(.connectionError)
            } else {
                completion(.invalidData)
            }
            
        })
    }
}



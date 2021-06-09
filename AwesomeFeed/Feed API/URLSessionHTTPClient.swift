//
//  URLSessionHTTPClient.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 5/30/21.
//

import Foundation

public class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    struct UnexpectedValueRepresentation: Error {
        
    }
    
    public func get(url: URL, completion: @escaping (HTTPClient.Result) -> Void) {
        self.session.dataTask(with: url, completionHandler: { data, response, error in
            completion( Result(catching: {
                if let error = error {
                    throw error
                } else if let data = data, let response = response as? HTTPURLResponse {
                    return (data, response)
                } else {
                    throw UnexpectedValueRepresentation()
                }
            }))
        }).resume()
    }
}

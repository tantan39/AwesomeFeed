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
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let response = response as? HTTPURLResponse {
                completion(.success((data, response)))
            } else {
                completion(.failure(UnexpectedValueRepresentation()))
            }
        }).resume()
    }
}

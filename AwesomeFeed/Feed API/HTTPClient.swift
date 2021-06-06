//
//  HTTPClient.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 5/28/21.
//

import Foundation
public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func get(url: URL, completion: @escaping (HTTPClientResult) -> Void)
}

//
//  FeedEndpoint.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 8/16/21.
//

import Foundation

public enum FeedEndpoint {
    case get
    
    public func url(baseURL: URL) -> URL {
        switch self {
        case .get:
            return baseURL.appendingPathComponent("/v1/feed")
        }
    }
}

//
//  ImageCommentsEndpoint.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 8/16/21.
//

import Foundation

public enum ImageCommentsEndpoint {
    case get(UUID)
    
    public func url(baseURL: URL) -> URL {
        switch self {
        case let .get(id):
            return baseURL.appendingPathComponent("/v1/image/\(id)/comments")
        }
    }
}

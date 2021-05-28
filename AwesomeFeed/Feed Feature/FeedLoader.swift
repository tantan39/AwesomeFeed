//
//  FeedLoader.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 5/27/21.
//

import Foundation

public enum LoadFeedResult<Error: Swift.Error> {
    case success([FeedItem])
    case failure(Error)
}

extension LoadFeedResult: Equatable where Error: Equatable { }

public protocol FeedLoader {
    associatedtype Error: Swift.Error
    func loadFeed(completion: @escaping (LoadFeedResult<Error>) -> Void)
}



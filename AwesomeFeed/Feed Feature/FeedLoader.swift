//
//  FeedLoader.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 5/27/21.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedImage])
    case failure(Error)
}

public protocol FeedLoader {

    func load(completion: @escaping (LoadFeedResult) -> Void)
}



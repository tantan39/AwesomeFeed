//
//  FeedCache.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 7/12/21.
//


public protocol FeedCache {
    typealias Result = Swift.Result<Void, Error>
    
    func save(_ feed: [FeedImage], completion: @escaping (Result) -> Void)
}

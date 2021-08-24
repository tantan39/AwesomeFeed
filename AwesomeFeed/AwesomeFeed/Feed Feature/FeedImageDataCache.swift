//
//  FeedImageDataCache.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 7/12/21.
//


public protocol FeedImageDataCache {
//    typealias Result = Swift.Result<Void, Error>
//    func save(_ data: Data, for url: URL, completion: @escaping (Result) -> Void)
    
    func save(_ data: Data, for url: URL) throws
}

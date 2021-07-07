//
//  FeedImageDataStore.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 7/7/21.
//

import Foundation

public protocol FeedImageDataStore {
    typealias Result = Swift.Result<Data?, Error>

    func retrieve(dataForURL url: URL, completion: @escaping (Result) -> Void)
}

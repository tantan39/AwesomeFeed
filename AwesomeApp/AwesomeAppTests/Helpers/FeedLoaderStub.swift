//
//  FeedLoaderStub.swift
//  AwesomeAppTests
//
//  Created by Tan Tan on 7/12/21.
//

import AwesomeFeed

class FeedLoaderStub: FeedLoader {
    private let result: FeedLoader.Result
    
    init(result: FeedLoader.Result) {
        self.result = result
    }
    
    func load(completion: @escaping (FeedLoader.Result) -> Void) {
        completion(result)
    }

}

//
//  FeedImageDataLoader.swift
//  AwesomeFeediOS
//
//  Created by Tan Tan on 6/14/21.
//

import Foundation

//public protocol FeedImageDataLoaderTask {
//    func cancel()
//}

public protocol FeedImageDataLoader {
//    typealias Result = Swift.Result<Data, Error>
    
//    func loadImageData(from url: URL, completion: @escaping (Result) -> Void) -> FeedImageDataLoaderTask
    
    func loadImageData(from url: URL) throws -> Data
}

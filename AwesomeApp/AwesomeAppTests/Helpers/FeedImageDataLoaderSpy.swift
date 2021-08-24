//
//  FeedImageDataLoaderSpy.swift
//  AwesomeAppTests
//
//  Created by Tan Tan on 7/12/21.
//

import AwesomeFeed

//class FeedImageDataLoaderSpy: FeedImageDataLoader {
//    private var messages = [(url: URL, completion: (Result<Data, Error>) -> Void)]()
//    
//    private(set) var cancelledURLs = [URL]()
//
//    var loadedURLs: [URL] {
//        return messages.map { $0.url }
//    }
//
//    func loadImageData(from url: URL) throws -> Data {
//        messages.append((url, completion))
//        return Task { [weak self] in
//            self?.cancelledURLs.append(url)
//        }
//    }
//
//    func complete(with error: Error, at index: Int = 0) {
//        messages[index].completion(.failure(error))
//    }
//
//    func complete(with data: Data, at index: Int = 0) {
//        messages[index].completion(.success(data))
//    }
//}

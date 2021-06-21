//
//  FeedViewModel.swift
//  AwesomeFeediOS
//
//  Created by Tan Tan on 6/21/21.
//

import AwesomeFeed

final class FeedViewModel {
    typealias Observer<T> = (T) -> Void
    
    private let feedLoader: FeedLoader
    
    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }
    
    var onLoadingStateChange: (Observer<Bool>)?
    var onFeedLoad: (Observer<[FeedImage]>)?
    
    func loadFeed() {
        onLoadingStateChange?(true)
        feedLoader.load(completion: { [weak self] result in
            if let feed = try? result.get() {
                self?.onFeedLoad?(feed)
            }
            self?.onLoadingStateChange?(false)
        })
    }
}

//
//  LocalFeedLoader.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 6/1/21.
//

import Foundation

public final class LocalFeedLoader {
    private var store: FeedStore
    private var currentDate: () -> Date
    
    public init(store: FeedStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }
    
    public func save(_ items: [FeedItem], completion: @escaping (Error?) -> Void) {
        store.deleteCachedFeed { [weak self] error in
            guard let self = self else { return }
            
            if let cacheDeletionError = error {
                completion(cacheDeletionError)
            } else {
                self.cache(items, with: completion)
            }
        }
    }
    
    private func cache(_ items: [FeedItem], with completion: @escaping (Error?) -> Void) {
        self.store.insert(items, timestamp: self.currentDate(), completion: { [weak self] error in
            guard self != nil else { return }
            completion(error)
        })

    }
}

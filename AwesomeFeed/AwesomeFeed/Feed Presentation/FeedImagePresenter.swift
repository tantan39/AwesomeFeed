//
//  FeedImagePresenter.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 6/29/21.
//

import Foundation

public final class FeedImagePresenter {
    
    public static func map(_ image: FeedImage) -> FeedImageViewModel {
        return FeedImageViewModel(
            description: image.description,
            location: image.location)
    }
}

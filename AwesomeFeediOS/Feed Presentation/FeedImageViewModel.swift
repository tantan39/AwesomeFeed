//
//  FeedImageViewModel.swift
//  AwesomeFeediOS
//
//  Created by Tan Tan on 6/21/21.
//

import AwesomeFeed

public struct FeedImageViewModel<Image> {
    let description: String?
    let location: String?
    let image: Image?
    let isLoading: Bool
    let shouldRetry: Bool
    
    var hasLocation: Bool {
        return location != nil
    }
}

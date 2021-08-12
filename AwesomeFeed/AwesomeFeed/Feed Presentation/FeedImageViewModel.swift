//
//  FeedImageViewModel.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 6/29/21.
//

import Foundation

public struct FeedImageViewModel {
    public let description: String?
    public let location: String?

    public var hasLocation: Bool {
        return location != nil
    }
}

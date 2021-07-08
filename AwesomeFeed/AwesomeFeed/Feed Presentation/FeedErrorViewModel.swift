//
//  FeedErrorViewModel.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 6/29/21.
//

import Foundation

public struct FeedErrorViewModel {
    public var message: String?
    
    static var noError: FeedErrorViewModel {
        return FeedErrorViewModel(message: nil)
    }
    
    static func error(message: String) -> FeedErrorViewModel {
        return FeedErrorViewModel(message: message)
    }
}

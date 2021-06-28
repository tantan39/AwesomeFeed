//
//  FeedErrorViewModel.swift
//  AwesomeFeediOS
//
//  Created by Tan Tan on 6/28/21.
//

import Foundation

struct FeedErrorViewModel {
    var message: String?
    
    static var noError: FeedErrorViewModel {
        return FeedErrorViewModel(message: nil)
    }
    
    static func error(message: String) -> FeedErrorViewModel {
        return FeedErrorViewModel(message: message)
    }
}

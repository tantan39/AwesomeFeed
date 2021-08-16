//
//  SharedTestHelpers.swift
//  AwesomeAppTests
//
//  Created by Tan Tan on 7/9/21.
//

import Foundation
import AwesomeFeed

func anyURL() -> URL {
    return URL(string: "http://a-url.com")!
}

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyData() -> Data {
    return Data("any data".utf8)
}

func uniqueFeed() -> [FeedImage] {
    return [FeedImage(id: UUID(), description: "any", location: "any", url: anyURL())]
}

private class DummyView: ResourceView {
    func display(_ viewModel: Any) { }
}

var loadError: String {
    return LoadResourcePresenter<Any, DummyView>.loadError
}

var feedTitle: String {
    return FeedPresenter.title
}

var commentsTitle: String {
    return ImageCommentsPresenter.title
}

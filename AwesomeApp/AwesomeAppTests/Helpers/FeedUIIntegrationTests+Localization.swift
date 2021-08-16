//
//  FeedViewControllerTests+Localization.swift
//  AwesomeFeediOSTests
//
//  Created by Tan Tan on 6/24/21.
//

import XCTest
import AwesomeFeed

extension FeedUIIntegrationTests {
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
}

//
//  FeedImagePresenterTests.swift
//  AwesomeFeedTests
//
//  Created by Tan Tan on 6/29/21.
//

import XCTest
import AwesomeFeed

class FeedImagePresenterTests: XCTestCase {
    
    func test_map_createsViewModel() {
        let image = uniqueImage()
        
        let viewModel = FeedImagePresenter.map(image)
        
        XCTAssertEqual(viewModel.description, image.description)
        XCTAssertEqual(viewModel.location, image.location)
    }
}

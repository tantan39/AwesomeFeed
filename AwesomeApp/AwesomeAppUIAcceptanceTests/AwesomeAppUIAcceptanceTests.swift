//
//  AwesomeAppUIAcceptanceTests.swift
//  AwesomeAppUIAcceptanceTests
//
//  Created by Tan Tan on 7/22/21.
//

import XCTest

class AwesomeAppUIAcceptanceTests: XCTestCase {
    func test_onLaunch_displaysRemoteFeedWhenCustomerHasNoConnectivity() {
        let app = XCUIApplication()
        
        app.launch()
        
        let feedCells = app.cells.matching(identifier: "feed-image-cell")
        XCTAssertEqual(feedCells.count, 22)
        
        let firstImage = app.images.matching(identifier: "feed-image-view").firstMatch
        XCTAssertTrue(firstImage.exists)
    }
}

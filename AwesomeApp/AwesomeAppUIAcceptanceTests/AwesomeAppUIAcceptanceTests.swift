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
        
        XCTAssertEqual(app.cells.count, 22)
        XCTAssertEqual(app.cells.firstMatch.images.count, 1)
    }
}

//
//  FeedViewControllerTests+Localization.swift
//  AwesomeFeediOSTests
//
//  Created by Tan Tan on 6/24/21.
//

import XCTest
import AwesomeFeed

extension FeedUIIntegrationTests {
    func localized(_ key: String, file: StaticString = #filePath, line: UInt = #line) -> String {
        let table = "Feed"
        let bundle = Bundle(for: FeedPresenter.self)
        let value = bundle.localizedString(forKey: key, value: nil, table: table)
        if value == key {
            XCTFail("Missing localized string for key: \(key) in table: \(table)", file: file, line: line)
        }
        return value
    }
}

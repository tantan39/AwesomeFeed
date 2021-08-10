//
//  FeedLocalizationTests.swift
//  AwesomeFeediOSTests
//
//  Created by Tan Tan on 6/24/21.
//

import XCTest
import AwesomeFeed

final class FeedLocalizationTests: XCTestCase {
    func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
        let table = "Feed"
        let bunble = Bundle(for: FeedPresenter.self)
        
        assertLocalizedKeyAndValuesExits(bundle, table)

    }
    
}

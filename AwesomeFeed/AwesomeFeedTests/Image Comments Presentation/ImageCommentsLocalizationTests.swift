//
//  ImageCommentsLocalizationTests.swift
//  AwesomeFeedTests
//
//  Created by Tan Tan on 8/12/21.
//

import XCTest
import AwesomeFeed

class ImageCommentsLocalizationTests: XCTestCase {

    func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
        let table = "ImageComments"
        let bundle = Bundle(for: ImageCommentsPresenter.self)
        
        assertLocalizedKeyAndValuesExits(in: bundle, table)
    }

}

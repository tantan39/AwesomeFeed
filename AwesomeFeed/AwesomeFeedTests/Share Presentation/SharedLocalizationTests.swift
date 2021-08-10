//
//  SharedLocalizationTests.swift
//  AwesomeFeedTests
//
//  Created by Tan Tan on 8/10/21.
//

import XCTest
import AwesomeFeed
class SharedLocalizationTests: XCTestCase {

    func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
        let table = "Shared"
        let bundle = Bundle(for: LoadResourcePresenter<Any, DummyView>.self)
        
        assertLocalizedKeyAndValuesExits(bundle, table)
    }
    
    private class DummyView: ResourceView {
        func display(_ viewModel: Any) {
            
        }
    }
}

//
//  XCTestCase+MemoryLeakTracking.swift
//  AwesomeFeedTests
//
//  Created by Tan Tan on 5/30/21.
//

import XCTest

extension XCTestCase {
    func trackMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been dellocated. Potential memory leak", file: file, line: line)
        }
    }
}
